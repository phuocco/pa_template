import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/language_module/language_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LanguagePage extends GetWidget<LanguageController> {
  @override
  Widget build(BuildContext context) {
    print("rebuild");

        return ListView(
          children: [
            TextButton(
                onPressed: () => Get.updateLocale(Locale('en', 'US')),
                child: Text('english')),
            TextButton(
                onPressed: () {
                  Get.updateLocale(Locale('vi', 'VN'));
                },
                child: Text('action_share'.tr)),
            Text('misc_loading_message'.tr),
            TextButton(
              onPressed: () {
                Get.find<HomeController>().selectPage(0);
                print('back');
              },
              child: Text('back to home'),
            ),
          ],
        );
  }
}
