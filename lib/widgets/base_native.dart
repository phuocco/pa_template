import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/constants/const_drawer.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class BaseNative extends StatelessWidget {

  final controller = Get.put(AdsController());

  @override
  Widget build(BuildContext context) {
    AdWidget ads =  AdWidget(ad: controller.myNativeAd);
    print('build new object');
    return  GetBuilder<AdsController>(
      initState: (state){
        Get.find<AdsController>().initNativeAds();
      },
      builder: (controller) {
        print("count 1 rebuild");
        return Obx(() => controller.isLoaded.value ? Container(
          width: double.infinity,
          height: GetPlatform.isAndroid ? 150 : 130,
          child: ads,
          color: kBackgroundContainerNativeAds,
        ): Container());
      },
    );
  }
}
