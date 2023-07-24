import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:juna_bhajan/view/ads/ads_retry_policy.dart';

/// Signature for [BannerAd] builder.
typedef BannerAdBuilder = BannerAd Function({
  required AdSize size,
  required String adUnitId,
  required BannerAdListener listener,
  required AdRequest request,
});

/// Signature for [AnchoredAdaptiveBannerAdSize] provider.
typedef AnchoredAdaptiveAdSizeProvider = Future<AnchoredAdaptiveBannerAdSize?>
    Function(
  Orientation orientation,
  int width,
);

class AnchoredRetryAdsView extends StatefulWidget {
  const AnchoredRetryAdsView({
    required this.adsRetryPolicy,
    required this.adUnitId,
    this.adBuilder = BannerAd.new,
    this.anchoredAdaptiveAdSizeProvider =
        AdSize.getAnchoredAdaptiveBannerAdSize,
    super.key,
  });

  /// The retry policy for loading ads.
  final AdsRetryPolicy adsRetryPolicy;

  /// The unit id of this banner ad.
  final String adUnitId;

  /// The builder of this banner ad.
  final BannerAdBuilder adBuilder;

  /// The provider for this banner ad for [BannerAdSize.anchoredAdaptive].
  final AnchoredAdaptiveAdSizeProvider anchoredAdaptiveAdSizeProvider;

  @override
  State<AnchoredRetryAdsView> createState() => _AnchoredRetryAdsViewState();
}

class _AnchoredRetryAdsViewState extends State<AnchoredRetryAdsView>
    with AutomaticKeepAliveClientMixin {
  BannerAd? _ad;
  AdSize? _adSize;
  bool _adLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.adsRetryPolicy.isShowAds) {
      unawaited(_loadAd());
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _adLoaded
        ? SizedBox(
            key: const Key('bannerAdContent_sizedBox'),
            width: (_adSize?.width ?? 0).toDouble(),
            height: (_adSize?.height ?? 0).toDouble(),
            child: Center(child: AdWidget(ad: _ad!)),
          )
        : const SizedBox();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadAd() async {
    AdSize? adSize = await _getAnchoredAdaptiveAdSize();

    setState(() => _adSize = adSize);

    if (_adSize == null) {
      FimberLog("AnchoredAdaptiveView")
          .e('Unable to get size of anchored banner.');
    }

    await _loadAdInstance();
  }

  Future<void> _loadAdInstance({int retry = 0}) async {
    if (!mounted) return;

    try {
      final adCompleter = Completer<Ad>();

      setState(
        () => _ad = widget.adBuilder(
          adUnitId: widget.adUnitId,
          request: const AdRequest(),
          size: _adSize!,
          listener: BannerAdListener(
            onAdLoaded: adCompleter.complete,
            onAdFailedToLoad: (_, error) {
              adCompleter.completeError(error);
            },
          ),
        )..load(),
      );

      _onAdLoaded(await adCompleter.future);
    } catch (error) {
      if (widget.adsRetryPolicy.isRetryAds &&
          retry < widget.adsRetryPolicy.maxRetryCount) {
        final nextRetry = retry + 1;
        await Future<void>.delayed(
          widget.adsRetryPolicy.getIntervalForRetry(nextRetry),
        );
        return _loadAdInstance(retry: nextRetry);
      }
    }
  }

  void _onAdLoaded(Ad ad) {
    if (mounted) {
      setState(() {
        _ad = ad as BannerAd;
        _adLoaded = true;
      });
    }
  }

  /// Returns an ad size for [BannerAdSize.anchoredAdaptive].
  ///
  /// Only supports the portrait mode.
  Future<AnchoredAdaptiveBannerAdSize?> _getAnchoredAdaptiveAdSize() async {
    final adWidth = MediaQuery.of(context).size.width.truncate();
    return widget.anchoredAdaptiveAdSizeProvider(
      Orientation.portrait,
      adWidth,
    );
  }
}
