import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/constants/const_drawer.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class BaseBanner extends StatelessWidget {

  final AdsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    AdWidget ads =  AdWidget(ad: controller.myBanner);
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
          color: kBackgroundContainerBannerAds,
        ): Container());
      },
    );
  }
}
