import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/functions/util_functions.dart';

class MainDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/rainbow.png'),
              fit: BoxFit.fill,
            )),
            child: Center(
                child: Container(
                    width: 75,
                    height: 75,
                    child: Image.asset(
                      'assets/images/ic_launcher.png',
                    ))),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              ListTile(
                onTap: () {
                  controller.selectPage(0);
                  Get.back();
                },
                title: Text('Item 0'),
              ),
              ListTile(
                onTap: () {
                  controller.selectPage(1);
                  Get.back();
                },
                title: Text('Item 1'),
              ),
              ListTile(
                onTap: () {
                  controller.selectPage(2);
                  Get.back();
                },
                title: Text('Item 2'),
              ),
              ListTile(
                onTap: null,
                title: Text('Item 2'),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

Widget drawerItem(String icIcon, String text, Function onTapDrawerItem) {
  return ListTile(
    onTap: onTapDrawerItem,
    leading: ConstrainedBox(
      constraints: kLeadingBox,
      child: Image.asset(
        icIcon,
        fit: BoxFit.cover,
        color: kColorImageDrawer,
      ),
    ),
    title: Text(text, style: kTextStyleIconDrawer),
  );
}
