import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/saved_module/saved_page.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/util_functions.dart';

class MainScreen extends GetWidget<HomeController> {
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Text(adsController.a),
          TextButton(
            onPressed: () => controller.changeText(),
            child: Obx(() => Text(controller.text.value)),
          ),
          Obx(() => Text(
              controller.list.value[controller.selectingPage.value]['title'])),
          TextButton(
              onPressed: () {
                Get.to(() => SavedPage());
                // adsController.dispose();
              },
              child: Text('To Saved Screen')),
          TextButton(
            onPressed: () => Get.snackbar("hi", "hello",
                snackPosition: SnackPosition.BOTTOM,
                margin:
                    EdgeInsets.only(bottom: UtilFunctions().getHeightBanner())),
            child: Text(
              'snack bar',
            ),
          ),
          TextButton(
              onPressed: () {
              //  adsController.showIntersAds();
                Get.to(() => SavedPage());
              },
              child: Text('show inters')),
          TextButton(
            onPressed: () {
              adsController.showRewardedAd();

            },
            child: Obx(
              () => Text(adsController.count.value.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
