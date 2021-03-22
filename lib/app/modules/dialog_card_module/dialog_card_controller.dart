import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/dialog_card_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/functions/util_functions.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardController extends GetxController {
  final DialogCardRepository repository;

  DialogCardController({this.repository});

  final listRate = <String>[].obs;
  final isRated = false.obs;

  final box = GetStorage();

   getSharedPref() async {
     if(box.hasData('LIST_RATE')){
        List<String> myList = box.read('LIST_RATE').cast<String>();
        listRate.assignAll(myList);
     }
    print(listRate);
     print('hiiiii');
    return listRate;
  }


   checkRated( String id) {
     print('check');
     isRated.value = false;
      if(!listRate.isBlank){
        var checkID = listRate.where((element) => id == element);
        print(id);
        if(!checkID.isBlank) {
          print('blank');
          isRated.value = true;
        } else {
          isRated.value = false;
        }
      }

  }

  rateCard(String id) async {
    print(id);
    listRate.add(id);
    await box.write('LIST_RATE', listRate.toList());
  }

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
      paddingAll = heightScreen * 0.11;
    } else {
      paddingAll = widthScreen * 0.23;
    }
    double heightUsed = UtilFunctions().getHeightBanner() +
        Get.mediaQuery.padding.top +
        kToolbarHeight +
        paddingAll;
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
