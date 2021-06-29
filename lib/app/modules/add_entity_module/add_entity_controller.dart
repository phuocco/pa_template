import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/creator.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityController extends GetxController with SingleGetTickerProviderMixin {

  final AddEntityRepository repository;
  AddEntityController({this.repository});

  CreatorController creatorController;

  Animation animation;
  AnimationController animationController;

  var isExpand = true.obs;
  var textId = ''.obs;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  var name = ''.obs;
  var power = ''.obs;
  var gravity = ''.obs;
  var damage = ''.obs;
  var shotDelay = ''.obs;

  var explodePower = ''.obs;


  static const String mEntityKey = "minecraft:entity";
  static const String mItemKey = "minecraft:item";

  static const String mProjectileKey = "minecraft:projectile";
  static const String mTeleportKey = "minecraft:teleport";
  static const String componentsKey = "components";
  static const String mMaxStackSize = "minecraft:max_stack_size";
  static const String mStackedByData = "minecraft:stacked_by_data";


  var teleport;
  var components;

  var isTeleport = false.obs;
  var isKnockBack = true.obs;
  var isCatchFire = true.obs;
  var isExplodeCausesFire = true.obs;

  var textCtrlId = TextEditingController();
  var textCtrlName = TextEditingController();
  var textCtrlPower = TextEditingController();
  var textCtrlGravity = TextEditingController();
  var textCtrlShotDelay = TextEditingController();
  var textCtrlExplodePower = TextEditingController();

  setSwitch(String type, bool value){
    print(!value);
    switch (type){
      case 'Teleport':
        isTeleport.value = !value;
        break;
      case 'KnockBack':
        isKnockBack.value = !value;
        break;
      case 'CatchFire':
        isCatchFire.value = !value;
        break;
      case 'ExplodeCausesFire':
        isExplodeCausesFire.value = !value;
        break;
    }
  }

  Future getData(CreatorController creatorController,  CreatorItem item) async {

    creatorController.componentsDefault = jsonDecode(jsonEncode(creatorController.componentsDefault));
    print('a');

    if(item.entities == null){
      item.entities = await creatorController.getEntityDynamic(item.itemEntityDir);
    }
    print('a');
    components = item.entities[mItemKey][componentsKey];
    teleport = components[mTeleportKey];

    isTeleport.value = teleport == null
        ? false
        : true;
    teleport = Map.from(isTeleport.value
        ? teleport
        : creatorController.componentsDefault[mTeleportKey]);
    update();
  }

  sendBackCreatorItem(CreatorController creatorController,  CreatorItem item){
    //todo get item after edit
    components['minecraft:teleport'] =
    isTeleport.value ? teleport : null;

    item.entities["minecraft:entity"]["components"] = components;
    print('a');
  }

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutSine,
    );
    animationController.forward();
  }


  @override
  void onReady() {
    super.onReady();

  }

  setTextId(String text){
    textId.value = text;
  }

  setExpand(bool value, {String type}){
    //todo more item, animation
    isExpand.value = !value;
    if (!value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    update();
  }



  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    animationController.dispose();
  }
}
