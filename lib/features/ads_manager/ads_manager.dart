import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sayyor/core/ads/ads.dart';

class AdsManager {
  BannerAd? _bannerAd;

  void loadBanner(Function() onAdLoaded) {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsHelper.bannerUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }
  BannerAd? get bannerAd => _bannerAd;

  void dispose() {
    _bannerAd?.dispose();
  }
}
