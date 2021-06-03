import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:launch_review/launch_review.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:mods_guns/app/data/provider/home_provider.dart';
import 'package:mods_guns/app/data/repository/home_repository.dart';
import 'package:mods_guns/app/modules/home_module/home_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/constants/const_drawer.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/functions/util_functions.dart';
import 'package:package_info/package_info.dart';

class MainDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      drawerItem(kHomeIcon, 'nav_items_home'.tr, () {
        Get.find<HomeController>().selectPageNew('Main Page');
        Get.back();
      }),
      drawerItem(kGuideIcon, 'nav_items_guide'.tr, () {
        Get.find<HomeController>().selectPageNew('Tutorial Page');
        Get.back();
      }),
      drawerItem(kQuestionIcon, 'nav_items_question'.tr, () {
        Get.find<HomeController>().selectPageNew('Question Page');
        Get.back();
      }),
      drawerItem(kReviewIcon, 'nav_items_review'.tr, () async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String packageName;
        if (GetPlatform.isAndroid) {
          packageName = packageInfo.packageName;
          LaunchReview.launch(androidAppId: packageName, writeReview: true);
        } else {
          HomeProvider().fetchAppInfo(packageInfo.packageName).then((value) {
            packageName = value.results[0].trackId.toString();
            print(packageName);
            LaunchReview.launch(iOSAppId: packageName, writeReview: true);
          });
        }

        GetStorage().write('OPEN_TIMES', 1);
      }),
      // drawerItem(kSubmitIcon, 'nav_items_submit'.tr, () {
      //   Get.find<HomeController>().selectPage(4);
      //   Get.back();
      // }),
      drawerItem(kLanguageIcon, 'nav_items_language'.tr, () {
        Get.find<HomeController>().selectPageNew('Language Page');
        Get.back();
      }),
      drawerItem(kPrivacyIcon, 'nav_items_policy'.tr, () {
        Get.back();
        PACoreShowDialog.policyDialog(context, title: 'Privacy Policy',policyAcceptTime: '', funcOk: ()=> Get.back());

      }),
      drawerItem(kAboutIcon, 'nav_items_about'.tr, () {
        Get.find<HomeController>().selectPageNew('About Page');
        Get.back();
      }),
     
    ];
    return Drawer(
      child: Column(
        children: [
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage(kBackgroundHorizontalImage),
            //       fit: BoxFit.cover),
            // ),
            color: kColorAppbar,
            height: 190,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  kLauncherImage,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              color: kBackgroundDrawer,
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return items[index];
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 3,
                      color: Colors.white,
                    );
                  },
                  itemCount: items.length),
            ),
          ),
        ],
      ),
    );
  }
}

Widget drawerItem(String icIcon, String text, Function onTapDrawerItem) {
  return InkWell(
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
          style: TextStyle(color: Colors.black),
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
