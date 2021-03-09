
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  Offset center = Offset(0, 0);
  double radius = 30.0;
  bool enabled = false;
  Widget description = Container();

  // giong initState
  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // TODO: implement onInit
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

}