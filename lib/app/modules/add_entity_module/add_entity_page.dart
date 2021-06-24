import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/new_creator.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityPage extends GetWidget<AddEntityController> {

  final CreatorController creatorController =  Get.find();
  final NewCreatorItem newCreatorItem;
  final int index;
  AddEntityPage({this.newCreatorItem, this.index});
  TextEditingController textCtrlName = TextEditingController();
  TextEditingController textCtrlIcon = TextEditingController();
  TextEditingController textCtrlSkin =TextEditingController();
  @override
  Widget build(BuildContext context) {
    textCtrlName.text = newCreatorItem.itemName;
    textCtrlIcon.text = newCreatorItem.itemIcon;
    textCtrlSkin.text = newCreatorItem.itemSkin;
    return Scaffold(
      appBar: AppBar(title: Text('AddEntity Page'),actions: [
        IconButton(onPressed: () {
          newCreatorItem.itemName = textCtrlName.text;
          newCreatorItem.itemIcon = textCtrlIcon.text;
          newCreatorItem.itemSkin = textCtrlSkin.text;
          creatorController.save(newCreatorItem,index);
          Get.back();
        }, icon: Icon(Icons.save)),
      ],),
      body: Column(
        children: [
          TextField(
            controller: textCtrlName,
          ),
          TextField(
            controller: textCtrlIcon,
          ),TextField(
            controller: textCtrlSkin,
          ),

        ],
      ),
    );
  }
}
