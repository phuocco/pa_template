import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/base_native.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/custom_dialog.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:open_file/open_file.dart';
import 'package:pa_template/modules/card_module/card_model/card_model.dart';

class SavedPage extends StatelessWidget {
  final adsController = Get.put(AdsController());
  final  savedController = Get.put(SavedController());
  final  homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('App name'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
              child: Obx(() =>
                  // Image.file(File(homeController.cardDetail.value.cardImg))),
                Text(homeController.historyCard.value.card.cardImg)),
            ),
          ),
          buildNativeAdSection(),
        ],
      ),
    ));
  }

  buildNativeAdSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<AdsController>(builder: (ads) {
            return ads.isPremium.value
                ? SizedBox()
                : Container(
                    height: GetPlatform.isAndroid ? 150 : 130,
                    width: Get.width,
                    color: Colors.transparent,
                    child: BaseNative(),
                  );
          }),
          Container(
            height: 35,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff5f6368)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              ),
              child: Text(
                'OPEN',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //TODO: open file
                OpenFile.open(homeController.historyCard.value.card.cardImg);
              },
            ),
          ),
          Container(
            height: 35,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff5f6368)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              ),
              child: Text(
                'SHARE',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //TODO: share file
                savedController.uploadFile(File(homeController.historyCard.value.card.cardImg), 'MainImage');
                // UtilFunctions().share( homeController.historyCard.value.card.cardImg);
              },
            ),
          ),
          Container(
            height: 35,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff5f6368)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              ),
              child: Text(
                'UPLOAD',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //TODO: upload file
                final index = homeController.listHistory.indexWhere((element) => element.id == homeController.historyCard.value.id);
                savedController.uploadCard(homeController.historyCard.value, index);
                // savedController.uploadImageGetLinkNewServer(homeController.historyCard.value);
                // savedController.testUploadCard(homeController.historyCard.value.card);
              },
            ),
          ),
        ],
      ),
    );
  }
}
