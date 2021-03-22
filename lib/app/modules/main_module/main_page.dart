import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/saved_module/saved_page.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/purchase_screen.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MainPage extends GetWidget<HomeController> {
  final adsController = Get.put(AdsController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              final box = GetStorage();
              print(box.read('LIST_ITEM'));
            },
            child: Text('read list'),
          ),
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
                adsController.showIntersAds();
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
          TextButton(
            onPressed: () {

              print(box.read('IS_PREMIUM'));
            },
            child: Text('get shared'),
          ),
          TextButton(
            onPressed: () {
              // box.read('LIST_RATE');
              print(box.read('LIST_RATE'));
            },
            child: Text('remove shared'),
          ),


          RepaintBoundary(
              key: cardKey,
              child: Image.asset('assets/images/loading.png', height: 200,)),
        ],
      ),
    );
  }
}
