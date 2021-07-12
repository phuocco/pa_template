import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_page.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/creator.dart';
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
                Get.to(() => AddEntityPage(
                    creatorItem: projectItemsFromJson(
                        projectItemsToJson(controller.listSelectEntity[0]))));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                controller.exportAddon();
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () {
                print('a');
                print(controller.listDataProject.length);
              },
              icon: Icon(Icons.save_outlined)),
        ],
      ),
      body: Obx(() => ListView.builder(
          itemCount: controller.listDataProject.length,
          itemBuilder: (context, index) {
            return InkResponse(
              onTap: () => Get.to(() => AddEntityPage()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(controller.listDataProject[index].itemName),
                    Text(controller
                        .listDataProject[index]
                        .entities["minecraft:entity"]["components"]
                            ['minecraft:projectile']["power"]
                        .toString()),
                    Image.asset(
                        "assets/" + controller.listDataProject[index].itemIcon),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
