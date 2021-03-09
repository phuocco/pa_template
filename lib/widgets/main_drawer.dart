import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/home_controller.dart';

class MainDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: controller.closeDrawer,
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
