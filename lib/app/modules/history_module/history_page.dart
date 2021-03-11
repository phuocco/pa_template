import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/history_module/history_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryPage extends GetWidget<HistoryController> {
  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('History'),);
  }
}
