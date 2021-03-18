import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/base_banner.dart';
import 'package:pa_template/controllers/ads_controller.dart';
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
          int time = DateTime.now().millisecondsSinceEpoch;
          Future cardPathF = UtilFunctions().exportToImage(
              globalKey: cardKey,
              fileName: time.toString(),
              isSaveToGallery: true,
              folder: "");
          Future thumbnailPathF =  UtilFunctions().exportToImage(
              globalKey: cardKey,
              fileName: time.toString() + '_Thumbnail',
              isSaveToGallery: false,
              folder: '.thumbnail');

          await Future.wait([cardPathF,thumbnailPathF]).then((value) => print(value));
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
          onPressed: () => controller.selectPage(2),
          child: Icon(Icons.ac_unit),
        ),
        bottomNavigationBar: Container(
          height: 90,
          width: Get.width,
          color: Colors.transparent,
          child: BaseBanner(),
        ),


      ),
    );
  }
}
