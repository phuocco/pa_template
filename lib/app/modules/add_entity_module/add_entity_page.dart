import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/new_creator.dart';
import 'package:mods_guns/widgets/switcher_button.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityPage extends GetWidget<AddEntityController> {
  final CreatorController creatorController = Get.find();
  final NewCreatorItem newCreatorItem;
  final int index;
  AddEntityPage({this.newCreatorItem, this.index});
  TextEditingController textCtrlName = TextEditingController();
  TextEditingController textCtrlIcon = TextEditingController();
  TextEditingController textCtrlSkin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textCtrlName.text = newCreatorItem.itemName;
    textCtrlIcon.text = newCreatorItem.itemIcon;
    textCtrlSkin.text = newCreatorItem.itemSkin;
    // controller.onStart();
    return Scaffold(
      appBar: AppBar(
        title: Text('AddEntity Page'),
        actions: [
          IconButton(
              onPressed: () {
                newCreatorItem.itemName = textCtrlName.text;
                newCreatorItem.itemIcon = textCtrlIcon.text;
                newCreatorItem.itemSkin = textCtrlSkin.text;
                creatorController.save(newCreatorItem, index);
                Get.back();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textCtrlName,
            ),
            TextField(
              controller: textCtrlIcon,
            ),
            TextField(
              controller: textCtrlSkin,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Test'),
                SwitcherButton(
                  // size: 80,
                  onColor: Colors.green,
                  offColor: Colors.red,
                  value: true,
                  onChange: (value) {
                    print(value);
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Test'),
                SwitcherButton(
                  // size: 80,
                  onColor: Colors.green,
                  offColor: Colors.red,
                  value: true,
                  onChange: (value) {
                    controller.setExpand(value);
                  },
                )
              ],
            ),
            SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: controller.animation,
              child: Container(
                width: Get.width,
                height: 100,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

