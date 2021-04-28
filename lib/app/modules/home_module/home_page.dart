import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/app/utils/strings.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/widgets/base_banner.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/custom_dialog.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/widgets/base_app_bar.dart';
import 'package:pa_template/widgets/main_drawer.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

GlobalKey cardKey = new GlobalKey();
GlobalKey imageCardKey = new GlobalKey();

class HomePage extends StatelessWidget{
  final HomeController controller = Get.find();
  final AdsController adsController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController;
    // var scaffoldKey = GlobalKey<ScaffoldState>();

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: kColorAppbar,
      leading: IconButton(
          color: kColorPrimaryDark,
          icon: Obx(() => Icon(
            controller.selectingPage.value == 0 ? Icons.menu : Icons.arrow_back_ios,
          ),),
          onPressed: () {
            controller.selectingPage.value == 0
                ? controller.openDrawer()
                : controller.selectPage(0);
          }),
      title: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: kColorTextFieldAppBar,
        height: AppBar().preferredSize.height * 0.64,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                autofocus: false,
                controller: searchController,
                cursorColor: Colors.lightBlueAccent,
                style: TextStyle(color: Colors.white),
                onSubmitted: (text) {
                  //todo: search
                  // searchItem(context, text);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'searching'.tr,
                  isDense: true,
                  hintStyle: TextStyle(color: kColorTextDrawer, fontSize: 12),
                  contentPadding:
                  EdgeInsets.only(left: 10, bottom: 13, top: 10, right: 10),
                ),
              ),
            ),
            Container(
              color: kColorTextDrawer,
              height: AppBar().preferredSize.height * 0.45,
              width: 1,
            ),
            AspectRatio(
              aspectRatio: 1,
              child: IconButton(
                padding: EdgeInsets.all(1),
                icon: Icon(Icons.search, color: kColorTextDrawer),
                onPressed: () {
                  if(searchController!=null) {
                    //todo search
                   // searchItem(context, searchController.text);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 5),
          child: GestureDetector(
            onTap: () {
              //todo more app
             // provider.selectPage('MoreAppsScreen');
              print(nativeHomeAdControllerNew.listAds.length);
            },
            child: Image.asset(
              kMoreIcon,
              height: 29,
              width: 29,
              color: kColorMoreAppIcon,
            ),
          ),
        )

      ],
    );

    print('init home');
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        // key: scaffoldKey,
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: MainDrawer(),
        ),
        body: GetX<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.list.value[_.selectingPage.value]['page'];
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => adsController.requestPurchase(adsController.items[0]),
        //   child: Icon(Icons.ac_unit),
        // ),
        bottomNavigationBar: Container(
          height: 90,
          width: Get.width,
          color: kBottomColor,
          child: BaseBanner(),
        ),


      ),
    );
  }
}
