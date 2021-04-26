import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/data/repository/test_native_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TestNativeController extends GetxController{

  final TestNativeRepository repository;

  TestNativeController({this.repository});

   NativeAd nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nativeAd = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      request: AdRequest(),
      factoryId: 'adFactoryId',
      customOptions: <String, Object>{
        'type': 'NativeAdHome',
      },
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$NativeAd failedToLoad: $error');
          nativeAdCompleter.completeError(error);
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => nativeAd.load());
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nativeAd.dispose();
  }

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
