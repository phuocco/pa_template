import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_page.dart';
import 'package:pa_template/app/modules/history_module/history_page.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeController extends GetxController{

  final HomeRepository repository;

  HomeController({this.repository});

  final selectingPage = 0.obs;

  Offset center = Offset(0, 0);
  double radius = 30.0;
  bool enabled = false;
  Widget description = Container();

  List<Map<String, Object>> pages;
  final text = "aaa".obs;

  final list = Rx<List<Map<String, Object>>>([]);


  // giong initState
  // called immediately after the widget is allocated memory
  @override
  void onInit() {
  // TODO: implement onInit
  initPages();
  super.onInit();

  }

// called after the widget is rendered on screen
  @override
  void onReady() {
  // TODO: implement onReady
  super.onReady();
  }

  // giong dispose
  // called just before the Controller is deleted from memory
  @override
  void onClose() {
  // TODO: implement onClose
  super.onClose();
  }

  void initPages(){
  pages = [
  {'page': MainPage(), 'title': 'Main Screen'},
  {'page': GalleryPage(), 'title': 'Gallery Screen'},
  {'page': HistoryPage(), 'title': 'History Screen'},
  ];
  list.value.addAll([
  {'page': MainPage(), 'title': 'Main Screen'},
  {'page': GalleryPage(), 'title': 'Gallery Screen'},
  {'page': HistoryPage(), 'title': 'History Screen'},
  ]);
  }

  void selectPage(int id) {
  selectingPage.value = id;
  update();
  }
  void changeText() => text.value = "bbb";

  }
