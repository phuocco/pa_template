import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/search_module/search_controller.dart';
import 'package:pa_template/app/modules/search_module/search_page.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/app/utils/strings.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/controllers/native_ad_controller_new.dart';
import 'package:pa_template/models/downloaded_item_model.dart';
import 'package:pa_template/widgets/base_banner.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/custom_dialog.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/widgets/base_app_bar.dart';
import 'package:pa_template/widgets/main_drawer.dart';


GlobalKey cardKey = new GlobalKey();
GlobalKey imageCardKey = new GlobalKey();

class HomePage extends StatelessWidget{
  final HomeController controller = Get.find();
  final AdsController adsController = Get.find();
  final MainController mainController = Get.find();
  final SearchController searchController = Get.find();
  @override
  Widget build(BuildContext context) {

    // var scaffoldKey = GlobalKey<ScaffoldState>();
    FocusScopeNode currentFocus = FocusScope.of(context);
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: kColorAppbar,
      brightness: Brightness.dark,
      titleSpacing: 0,
      leading: IconButton(
          color: kColorPrimaryDark,
          icon: Obx(() => Icon(
            controller.selectingPageNew.value == 'Main Page' ? Icons.menu : Icons.arrow_back_ios,
          ),),
          onPressed: () {
            if(controller.selectingPageNew.value == 'Main Page'){
              controller.openDrawer();
            }
              else  {
              searchController.listAddonSearchWithAds.clear();
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
                  controller.selectPageNew('Search Page');
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

                  if(controller.searchTextEditingController!=null) {
                    //todo search
                    searchController.searchText = controller.searchTextEditingController.text;
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
              print(mainController.listDownloaded.length);
              controller.selectPageNew('More App Page');
             //  GetStorage().remove('LIST_FAVORITE');
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
          padding: const EdgeInsets.only(right:10),
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
        body: GetX<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.listPages[_.selectingPageNew];
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
