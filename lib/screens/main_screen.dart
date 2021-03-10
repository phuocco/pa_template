
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/home_controller.dart';
import 'package:pa_template/screens/saved_screen.dart';

class MainScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Column(
      children: [
        Text('Main'),
        TextButton(onPressed: () => controller.changeText(), child: Obx(() => Text(controller.text.value)),
        ),
        Obx(() => Text(controller.list.value[controller.selectingPage.value]['title'])),
        TextButton(onPressed: () => Get.to(SavedScreen()), child: Text('To Saved Screen')),
      ],
    ),);
  }

}