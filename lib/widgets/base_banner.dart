import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/constants/const_drawer.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class BaseBanner extends StatelessWidget {
  final AdsController controller = Get.find();
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.list.length == 0 || homeController.selectingPageNew.value == 'More App Page'
        ? Container(
            height: 0,
            width: double.infinity,
            color: Colors.transparent,
          )
        : Container(
            width: double.infinity,
            height: UtilFunctions().getHeightBanner(),
            child: AdWidget(ad: controller.list[0]),
            color: kBackgroundContainerBannerAds,
          ));
  }
}
