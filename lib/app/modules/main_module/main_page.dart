import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MainPage extends GetWidget<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
