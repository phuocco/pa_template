import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pa_template/controllers/home_controller.dart';
import 'package:pa_template/widgets/main_drawer.dart';

class HomeScreen extends GetView<HomeController> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('appbar'),
        ),
        drawer: MainDrawer(),
        body: GetBuilder(
          init: HomeController(),
          builder: (value) {
            return Text('a');
          },
        ),
      ),
    );
  }
}
