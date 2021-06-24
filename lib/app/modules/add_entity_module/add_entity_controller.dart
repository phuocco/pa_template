import 'package:flutter/material.dart';
import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityController extends GetxController with SingleGetTickerProviderMixin {

  final AddEntityRepository repository;

  AddEntityController({this.repository});

  Animation animation;
  AnimationController animationController;

  var isExpand = true.obs;
  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;


  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCirc,
    );
    animationController.forward();
  }

  setExpand(bool value){
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
