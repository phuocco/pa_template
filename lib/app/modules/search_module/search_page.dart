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
    controller.getSearchItems(context, controller.searchText);
    return  Obx(() => ListView.builder(itemCount:controller.listAddon.length ,itemBuilder: (context, index){
        return Card(
          child: Column(
            children: [
              Text(controller.listAddon[index].itemName),
            ],
          ),
        );
    }));
  }
}
