import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_page.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/new_creator.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorPage extends GetWidget {
  final CreatorController controller = Get.put(CreatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creator Page'),
        actions: [
          IconButton(
              onPressed: () {
                controller.add();
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
               String str =  newCreatorToJson([controller.newCreatorDefault.value]);
               print(str);
              },
              icon: Icon(Icons.update)),
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.newCreatorDefault.value.items.length,
            itemBuilder: (context, index) {
              if(index == 0){
                return InkResponse(
                  onTap: () {
                    print(controller.listDataDefault[0].toJson());
                    print('a');
                  },
                  child: Text('data'),
                );
              } else {
                return InkResponse(
                  onTap: () => Get.to(() => AddEntityPage(
                    creatorItem:
                    controller.listDataDefault[0],
                    index: index,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(controller
                            .newCreatorDefault.value.items[index].itemName),
                        Text(controller
                            .newCreatorDefault.value.items[index].itemIcon),
                        Text(controller
                            .newCreatorDefault.value.items[index].itemSkin)
                      ],
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}
