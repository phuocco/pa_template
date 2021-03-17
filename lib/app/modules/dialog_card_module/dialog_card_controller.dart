import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/dialog_card_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/functions/util_functions.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardController extends GetxController{

  final DialogCardRepository repository;

  DialogCardController({this.repository});

   double widthScreen, heightScreen;
   double widthCard, heightCard;


  void setSize() {
    widthScreen = Get.width;
    heightScreen = Get.height;

    double paddingAll;

    double ratioScreen = widthScreen / heightScreen;
    double ratioCard = 813 / 1185;
    print(ratioScreen);

    if (ratioScreen > 0.7) {
      paddingAll = heightScreen*0.11;
    } else {
      paddingAll = widthScreen * 0.23;
    }
    double heightUsed = UtilFunctions().getHeightBanner() +
        Get.mediaQuery.padding.top + kToolbarHeight + paddingAll;
    double widthUsed = widthScreen - paddingAll;
    double heightBlank = heightScreen - heightUsed;

    if (ratioScreen > ratioCard) {
      heightCard = heightBlank;
      widthCard = heightCard * ratioCard;
    } else {
      widthCard = widthUsed;
      heightCard = widthCard * 1 / ratioCard;
    }
  }

}
