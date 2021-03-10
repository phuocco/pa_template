import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/home_controller.dart';
import 'package:pa_template/screens/main_screen.dart';
import 'package:pa_template/utils/functions/util_functions.dart';
import 'package:pa_template/widgets/base_app_bar.dart';
import 'package:pa_template/widgets/main_drawer.dart';

class HomeScreen extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  final adsController = Get.put(AdsController());
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: adsController.myBanner);
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
      ],
    );
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: controller.scaffoldKey,
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
          onPressed: () => controller.selectPage(2),
          child: Icon(Icons.ac_unit),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: adWidget,
          width: double.infinity,
          height: UtilFunctions().getHeightBanner(),
        ),
      ),
    );
  }
}
