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

  final box = GetStorage();

  List getSharedPref() {
    box.hasData('LIST_RATE')
        ? listRate.assignAll(box.read('LIST_RATE'))
        : listRate.assignAll([]);

    return listRate;
  }

  updateSharedPref(String id) {
    List<String> temp = listRate;
    temp.add(id);
    box.remove('LIST_RATE');
    box.write('LIST_RATE', temp);
  }

  bool checkRated(String id) {
    bool isRated = false;
    List<String> temp = [];
    temp = box.read('LIST_RATE');
    if (box.hasData('LIST_RATE')) {
      var contain = temp.where((element) => id == element);
      if (contain.isNotEmpty) {
        isRated = true;
      } else {
        isRated = false;
      }
    } else {
      isRated = false;
    }
    return isRated;
  }

  rateCard(String id) {
    listRate.add(id);
    box.write('LIST_RATE', listRate);
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
