import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/home_controller.dart';
import 'package:pa_template/utils/functions/util_functions.dart';

class MainDrawer extends GetView<HomeController> {

  //TODO: extract widget
  // height banner
  // add leading image
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.65,
                child: Drawer(
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
                  title: Text('List 1'),
                  onTap: () => Get.dialog(
                    AlertDialog(
                      content: Text('Your current card will be lost!!!'),
                      actions: [
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: Text('Cancel')),
                        TextButton(onPressed: (){
                          Get.back();
                          Get.back();
                        }, child: Text('OK')),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () { controller.selectPage(0);
                  Get.back();
                  },
                  title: Text('Item 0'),
                ),
                ListTile(
                  onTap: () { controller.selectPage(1);
                  Get.back();
                  },
                  title: Text('Item 1'),
                ),ListTile(
                  onTap: () { controller.selectPage(2);
                  Get.back();
                  },
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),ListTile(
                  onTap: null,
                  title: Text('Item 2'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
