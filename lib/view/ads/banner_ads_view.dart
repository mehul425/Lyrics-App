import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/repository/ads_repository.dart';

class BannerAdsView extends StatefulWidget {
  final ProjectType projectType;

  const BannerAdsView({
    required this.projectType,
    Key? key,
  }) : super(key: key);

  @override
  State<BannerAdsView> createState() => _BannerAdsViewState();
}

class _BannerAdsViewState extends State<BannerAdsView> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    BannerAd(
      adUnitId:
          AdsRepository.getBannerAdUnitId(projectType: widget.projectType),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) {
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return Container();
    }
  }
}
