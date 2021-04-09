import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/utils/strings.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/functions/util_functions.dart';

class MainDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      drawerItem(kHomeIcon, 'nav_items_home'.tr, (){
        Get.find<HomeController>().selectPage(0);
        Get.back();
      }),
      drawerItem(kGuideIcon, 'nav_items_guide'.tr, (){
        Get.find<HomeController>().selectPage(2);
        Get.back();
      }),
      drawerItem(kQuestionIcon, 'nav_items_question'.tr, (){
        Get.find<HomeController>().selectPage(3);
        Get.back();
      }),
      drawerItem(kReviewIcon, 'nav_items_review'.tr, (){
        print('a');
      }),
      drawerItem(kSubmitIcon, 'nav_items_submit'.tr, (){
        print('a');
      }),
      drawerItem(kLanguageIcon, 'nav_items_language'.tr, (){
        Get.find<HomeController>().selectPage(1);
        Get.back();
      }),
      drawerItem(kPrivacyIcon, 'nav_items_policy'.tr, (){
        print('a');
      }),
      drawerItem(kAboutIcon, 'nav_items_about'.tr, (){
        print('a');
      }),
    ];
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(kBackgroundHorizontalImage),
                  fit: BoxFit.cover),
            ),
            height: 190,
            child: Center(
              child: Image.asset(
                kLauncherImage,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(top:5),
                color: Color(0xb2005c8c),
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index){
                  return items[index];
                }, separatorBuilder: (context, index){
                  return Divider(height: 3, color: Colors.white,);
                }, itemCount: items.length),
              ),),
        ],
      ),
    );
  }
}



Widget drawerItem(String icIcon, String text, Function onTapDrawerItem) {
  return GestureDetector(
    onTap: onTapDrawerItem,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //child: Icon(Icons.share),
          child: Image.asset(icIcon, color: Colors.blue, height: 24),
        ),
        Text(
          text,

        ),
      ],
    ),
  );
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
