import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/test_native_module/test_native_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/widgets/base_native.dart';

class TestNativePage extends GetWidget<TestNativeController> {
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {
    adsController.initNativeAds();
    return Scaffold(
      appBar: AppBar(title: Text('TestNative Page')),
      body: Container(
        child: Center(
          child: NativeAdHomeWidget(
              adWidget: AdWidget(
                ad: adsController.myNativeAd,
              ),
              completer: adsController.nativeAdCompleter),
        ),
      ),
    );
  }
}
