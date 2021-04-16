import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/test_native_module/test_native_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';

class TestNativePage extends GetWidget<TestNativeController> {
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('TestNative Page')),
      body: Container(
        child: Center(
          child: Container(),
        ),
      ),
    );
  }
}
