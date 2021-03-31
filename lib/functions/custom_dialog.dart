//will move to template

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/controllers/ads_controller.dart';

class CustomDialog {
  static inputNameDialog(
      {String title,
      String currentValue,
      bool isNumber,
      bool multiLine}) async {
    String value = currentValue;
    final textController = TextEditingController();
    if (currentValue != null) {
      textController.text = currentValue;
    }
    Get.dialog(AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Get.size.shortestSide,
          child: TextField(
            autofocus: true,
            controller: textController,
            keyboardType: isNumber
                ? TextInputType.number
                : multiLine != null
                    ? TextInputType.multiline
                    : TextInputType.text,
            onChanged: (onChangeValue) {
              value = onChangeValue;
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel'.toUpperCase(),
            style: kCancelDialogText,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text('Ok'.toUpperCase(),
          style: kOKDialogText,),
          onPressed: () {
            int time = DateTime.now().millisecondsSinceEpoch;
            Get.find<AdsController>().showIntersAds();
            Get.find<HomeController>().saveImage(time.toString() + "_" + value);
            Get.back();
            Get.toNamed('/saved');
          },
        ),
      ],
    ));
  }
}
