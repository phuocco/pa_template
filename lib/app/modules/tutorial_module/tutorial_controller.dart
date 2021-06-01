import 'package:flutter/material.dart';
import 'package:mods_guns/app/data/repository/tutorial_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TutorialController extends GetxController with SingleGetTickerProviderMixin{

  final TutorialRepository repository;

  TutorialController({this.repository});
  TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ADDON/TEXTURE'),
    Tab(text: 'MAP/SEED'),
    Tab(text: 'SKIN'),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = new TabController(length: 3, vsync: this);
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();
  }
}
