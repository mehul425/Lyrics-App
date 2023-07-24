import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/repository/ads_repository.dart';

class AnchoredAdaptiveView extends StatefulWidget {
  final ProjectType projectType;

  const AnchoredAdaptiveView({
    required this.projectType,
    Key? key,
  }) : super(key: key);

  @override
  State<AnchoredAdaptiveView> createState() => _AnchoredAdaptiveViewState();
}

class _AnchoredAdaptiveViewState extends State<AnchoredAdaptiveView> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLoaded = false;
    _loadAd();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      FimberLog("AnchoredAdaptiveView")
          .e('Unable to get size of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId:
          AdsRepository.getBannerAdUnitId(projectType: widget.projectType),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  void dispose() {
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_anchoredAdaptiveAd != null && _isLoaded) {
      return SizedBox(
        width: _anchoredAdaptiveAd!.size.width.toDouble(),
        height: _anchoredAdaptiveAd!.size.height.toDouble(),
        child: AdWidget(ad: _anchoredAdaptiveAd!),
      );
    } else {
      return Container();
    }
  }
}
