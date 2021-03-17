import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controllers/ads_controller.dart';
import 'functions/util_functions.dart';

class BaseBanner extends StatelessWidget {

  final controller = Get.put(AdsController());

  @override
  Widget build(BuildContext context) {
    AdWidget ads = new AdWidget(ad: controller.myBanner);
    print('build new object');
    return  GetBuilder<AdsController>(
      initState: (state){
        Get.find<AdsController>().initBannerAds();
      },
      builder: (controller) {
        print("count 1 rebuild");
        return Obx(() => controller.isLoaded.value ? Container(
          width: double.infinity,
          height: controller.isPremium.value == false ? UtilFunctions().getHeightBanner() : 0,
          child: ads,
          color: Colors.black12,
        ): Container());
      },
    );
  }
}
