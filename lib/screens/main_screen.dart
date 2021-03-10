import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/home_controller.dart';
import 'package:pa_template/screens/saved_screen.dart';
import 'package:pa_template/utils/functions/util_functions.dart';

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
                Get.to(() => SavedScreen());
                // adsController.dispose();
              },
              child: Text('To Saved Screen')),
          TextButton(onPressed: () => Get.snackbar("hi", "hello", snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(bottom: UtilFunctions().getHeightBanner())), child: Text('snack bar'),),
        ],
      ),
    );
  }
}
