import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:mods_guns/app/modules/home_module/home_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/constants/const_drawer.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'package:mods_guns/functions/util_functions.dart';
import 'package:mods_guns/models/downloaded_item_model.dart';
import 'package:mods_guns/widgets/base_banner.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/functions/custom_dialog.dart';
import 'package:mods_guns/widgets/base_app_bar.dart';
import 'package:mods_guns/widgets/main_drawer.dart';
import 'package:mods_guns/widgets/native_ad_detail_widget.dart';

GlobalKey cardKey = new GlobalKey();
GlobalKey imageCardKey = new GlobalKey();

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();
  final AdsController adsController = Get.find();
  final MainController mainController = Get.find();
  final SearchController searchController = Get.find();
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: kColorAppbar,
      brightness: Brightness.dark,
      titleSpacing: 0,
      leading: IconButton(
          color: kColorPrimaryDark,
          icon: Obx(
            () => Icon(
              controller.selectingPageNew.value == 'Main Page'
                  ? Icons.menu
                  : Icons.arrow_back_ios,
            ),
          ),
          onPressed: () {
            if (controller.selectingPageNew.value == 'Main Page') {
              controller.openDrawer();
            } else {
              searchController.listAddonSearchWithAds.clear();
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              controller.searchTextEditingController.text = '';
              controller.selectPageNew('Main Page');
            }
          }),
      title: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: kColorTextFieldAppBar,
        height: AppBar().preferredSize.height * 0.64,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                autofocus: false,
                controller: controller.searchTextEditingController,
                cursorColor: Colors.lightBlueAccent,
                style: TextStyle(color: Colors.black),
                onSubmitted: (text) {
                  //todo search
                  searchController.searchText = text;

                  if (!text.isBlank) controller.selectPageNew('Search Page');
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
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
                  if (controller.searchTextEditingController != null) {
                    //todo search
                    searchController.searchText =
                        controller.searchTextEditingController.text;
                    if (!controller.searchTextEditingController.text.isBlank)
                      controller.selectPageNew('Search Page');
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: GestureDetector(
            onTap: () async {
              //todo more app
              // provider.selectPage('MoreAppsScreen');
              controller.selectPageNew('More App Page');
              // print(GetStorage().read('LOCALE'));
            },
            child: Image.asset(
              kMoreIcon,
              height: 29,
              width: 29,
              color: kColorMoreAppIcon,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              controller.selectPageNew('Favorite Page');
            },
            child: SvgPicture.asset(
              'assets/images/icons/heart_red.svg',
              color: kColorLikeIcon,
            ),
          ),
        ),
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
        body: WillPopScope(
            child: GetX<HomeController>(
              init: HomeController(),
              builder: (_) {
                return _.listPages[_.selectingPageNew];
              },
            ),
            onWillPop: () async {
              if (controller.selectingPageNew.value == 'Main Page') {
                return Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 70,
                              child: Center(
                                child: Text(
                                  'Do you want to exit?',
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                            child: Text('CANCEL',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => SystemNavigator.pop(),
                                      child: Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: kColorAppbar,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                            child: Text('OK',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.05),
                              child: NativeAdDetailWidget(
                                  adItem: nativeDetailAdControllerNew
                                      .getAdsByIncreaseIndex()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    barrierDismissible: false);
              } else {
                Get.find<HomeController>().selectPageNew('Main Page');
                return false;
              }
            }),
        // bottomNavigationBar: Obx(() => adsController.list.length == 0
        //     ? Text(adsController.list.length.toString())
        //     :Text(adsController.list.length.toString()),)
        bottomNavigationBar: BaseBanner(),
      ),
    );
  }
}
