

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/screens/gallery_screen.dart';
import 'package:pa_template/screens/history_screen.dart';
import 'package:pa_template/screens/main_screen.dart';

class HomeController extends GetxController {
  final selectingPage = 0.obs;

  Offset center = Offset(0, 0);
  double radius = 30.0;
  bool enabled = false;
  Widget description = Container();

  List<Map<String, Object>> pages;
  final text = "aaa".obs;

  final list = Rx<List<Map<String, Object>>>([]);
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

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
        {'page': MainScreen(), 'title': 'Main Screen'},
        {'page': GalleryScreen(), 'title': 'Gallery Screen'},
        {'page': HistoryScreen(), 'title': 'History Screen'},
    ];
    list.value.addAll([
      {'page': MainScreen(), 'title': 'Main Screen'},
      {'page': GalleryScreen(), 'title': 'Gallery Screen'},
      {'page': HistoryScreen(), 'title': 'History Screen'},
    ]);
  }

  void selectPage(int id) {
    selectingPage.value = id;
    update();
  }
  void changeText() => text.value = "bbb";

}
