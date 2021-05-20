import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/search_module/search_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchPage extends StatelessWidget {
  final controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Obx(()=>Container(child: Text(controller.searchText),)),

    );
  }
}
