import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sayyor/features/ads_manager/ads_manager.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late AdsManager _adsManager;
  bool _isLoaded=false;
  @override
  void initState() {
    super.initState();
    _adsManager=AdsManager();
    _adsManager.loadBanner((){
      setState(() {
        _isLoaded=true;
      });
    });
  }
  @override
  void dispose() {
    _adsManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     if(_adsManager.bannerAd!=null && _isLoaded){
       return Container(
         alignment: Alignment.center,
         width: _adsManager.bannerAd!.size.width.toDouble(),
         height: _adsManager.bannerAd!.size.height.toDouble(),
         child: AdWidget(ad: _adsManager.bannerAd!),
       );
     };
     return SizedBox.shrink();
  }
}
