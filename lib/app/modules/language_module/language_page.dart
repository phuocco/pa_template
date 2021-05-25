import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/language_module/language_controller.dart';


class LanguagePage extends GetWidget<LanguageController> {





  @override
  Widget build(BuildContext context) {

        return GetBuilder<LanguageController>(
          init: LanguageController(),
          builder: (c){
            return ListView.builder(
                    itemCount: controller.localeCodeList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () {
                          Get.updateLocale(controller.localeCodeList[index]);
                          Get.find<HomeController>().selectPageNew('Main Page');
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black26))
                          ),
                          child: Text(controller.languageList[index]),
                        ),
                      );
                    });
          },
        );
     
  }
}
