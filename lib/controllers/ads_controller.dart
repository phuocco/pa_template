import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/utils/ad_manager.dart';

class AdsController extends GetxController {

  String a = "test";



  AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );

  AdRequest adRequest = AdRequest(
    testDevices: [
      'C53C9F562E282082EAFCDB42BF360BC1',
      '79A2C46F7F42017B2CD92F43970F4F2F',
      'e645b85f78980a92381fe225e3df5aec'
    ]
  );

  BannerAd myBanner;

  loadBanner() => myBanner.load();

  @override
  void onInit() {
    myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: adRequest,
      listener: listener,
    );
    super.onInit();
    loadBanner();
  }

  @override
  void onClose() {
    super.onClose();
    myBanner.dispose();
  }

  @override
  void onReady() {

  }
}
