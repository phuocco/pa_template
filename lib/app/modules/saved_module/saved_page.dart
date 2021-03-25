
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/widgets/base_native.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:open_file/open_file.dart';

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
              kPaddingImageSaved,
              child: Obx(() =>
                  Image.file(File(homeController.cardDetail.value.cardImg))),
                // Text(homeController.historyCard.value.card.cardImg)),
            ),
          ),
          buildNativeAdSection(),
        ],
      ),
    ));
  }

  buildNativeAdSection() {
    return Padding(
      padding:  kPaddingAdSection,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<AdsController>(builder: (ads) {
            return ads.isPremium.value
                ? SizedBox()
                : Container(
                    height: GetPlatform.isAndroid ? 150 : 130,
                    width: Get.width,
                    color: kBackgroundNativeAdColor,
                    child: BaseNative(),
                  );
          }),
          Container(
            height: kHeightSavedContainerButton,
            width: kWidthSavedContainerButton,
            margin: kPaddingSavedContainerButton,
            child: TextButton(
              style: kButtonStyleSavedContainer,
              child: Text(
                'OPEN',
                style: kSavedButtonText,
              ),
              onPressed: () {
                //TODO: open file
                OpenFile.open(homeController.historyCard.value.card.cardImg);
              },
            ),
          ),
          Container(
            height: kHeightSavedContainerButton,
            width: kWidthSavedContainerButton,
            margin: kPaddingSavedContainerButton,
            child: TextButton(
              style: kButtonStyleSavedContainer,
              child: Text(
                'SHARE',
                style: kSavedButtonText,
              ),
              onPressed: () {
                //TODO: share file
                // savedController.uploadFile(File(homeController.historyCard.value.card.cardImg), 'MainImage');
                // UtilFunctions().share( homeController.historyCard.value.card.cardImg);
              },
            ),
          ),
          Container(
            height: kHeightSavedContainerButton,
            width: kWidthSavedContainerButton,
            margin: kPaddingSavedContainerButton,
            child: TextButton(
              style: kButtonStyleSavedContainer,
              child: Text(
                'UPLOAD',
                style: kSavedButtonText,
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
