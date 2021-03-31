import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
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

class HomePage extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {

    var scaffoldKey = GlobalKey<ScaffoldState>();

    final appBar = AppBar(
      title: Text('Appbar'),
      actions: [
        BaseAppBar('assets icon', () {
          controller.selectPage(0);
          print('a');
        }, 'Main'),
        BaseAppBar('assets icon', () {
          controller.selectPage(1);
        }, 'Gallery'),
        BaseAppBar('assets icon', () {
          controller.selectPage(2);
        }, 'History'),
        IconButton(icon: Icon(Icons.save), onPressed: () async {
         CustomDialog.inputNameDialog(title: 'File name', currentValue: '', isNumber: false);
         }),
        IconButton(icon: Icon(Icons.add), onPressed: () async {

          // controller.getPref();

        //  GetStorage().remove('LIST_HISTORY');
        }),
      ],
    );
    print('init home');
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        drawer: MainDrawer(),
        body: GetX<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.list.value[_.selectingPage.value]['page'];
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => adsController.requestPurchase(adsController.items[0]),
          child: Icon(Icons.ac_unit),
        ),
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
