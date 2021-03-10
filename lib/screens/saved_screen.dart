import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/saved_controller.dart';
import 'package:pa_template/screens/home_screen.dart';

class SavedScreen extends GetView<SavedController> {
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: adsController.myNativeAd);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('App name'),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: Container(
          //     height: 300,
          //     width: 300,
          //     color: Colors.blue,
          //   ),
          //
          // ),
          Padding(padding: EdgeInsets.only(bottom: 2),child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextButton(
                  onPressed: () {
                    adsController.showIntersAds();
                    Get.back();
                  }, child: Text("a"),
                ),
              ),
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: adWidget,
                width: Get.width,
                height: 200,
              ),
            ],
          ),),
        ],
      ),
    ));
  }
}
