//will move to template

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
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
        FlatButton(
          child: Text(
            'Cancel'.toUpperCase(),
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        FlatButton(
          child: Text('Ok'.toUpperCase()),
          onPressed: () {
            int time = DateTime.now().millisecondsSinceEpoch;
            if (Get.find<AdsController>().isPremium.value) {
              Get.find<AdsController>().showIntersAds();
            }
            Get.find<HomeController>().saveImage(time.toString() + "_" + value);
            Get.back();

          },
        ),
      ],
    ));

  }


 static inputNameDialog2(BuildContext context,
     {String title,
       String currentValue,
       bool isNumber,
       bool multiLine}) async {
   String value = currentValue;
   final textController = TextEditingController();
   if (currentValue != null) {
     textController.text = currentValue;
   }
   return showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text(title),
           content: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Container(
               width: MediaQuery.of(context).size.shortestSide,
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
             FlatButton(
               child: Text(
                 'Cancel'.toUpperCase(),
                 style: TextStyle(color: Colors.grey),
               ),
               onPressed: () {
                 Navigator.pop(context);
               },
             ),
             FlatButton(
               child: Text('Ok'.toUpperCase()),
               onPressed: () {
                 int time = DateTime.now().millisecondsSinceEpoch;
                 Navigator.of(context).pop(time.toString() + "_" + value);
               },
             ),
           ],
         );
       });
 }

}
