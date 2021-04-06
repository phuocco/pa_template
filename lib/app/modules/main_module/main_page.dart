import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/test_native_module/test_native_page.dart';
import 'package:pa_template/app/routes/app_pages.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/widgets/base_native.dart';


class MainPage extends GetWidget<HomeController> {
  final adsController = Get.put(AdsController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // BaseNative(initAds:adsController.initNativeAds(),adWidget: AdWidget(ad: adsController.myNativeAd,), completer: adsController.nativeAdCompleter ),
           TextButton(onPressed: () => Get.toNamed(Routes.DETAIL, arguments: 'https://files.mcpedata.com/mcpeskins/files/movies/captainamerica.png'), child: Text('skin')),
            TextButton(onPressed: (){
              PACoreShowDialog.policyDialog(context,
                  title: "Policy",
                  policyAcceptTime:box.read("PRIVACY_POLICY").toString(), funcOk: () {
                    Navigator.pop(context);
                    print("ok");
                  });
            }, child: Text('dialog policy')),

            TextButton(
              onPressed: () {
                Get.to(TestNativePage());
              },
              child: Text(
                'snack bar',
              ),
            ),

            TextButton(
              onPressed: () => PACoreShowDialog.pickYearDialog(context,policyText: "aaaa"),
              child: Text('pick year'),
            ),
            TextButton(
              onPressed: () => print(box.read("PRIVACY_POLICY")),
              child: Text('print PRIVACY_POLICY'),
            ),
            TextButton(
              onPressed: () {
                Get.snackbar(box.read('OPEN_TIMES').toString(), 'hi');
              },
              child: Text('print open time'),
            ),

            TextButton(
              onPressed: () {
                adsController.showRewardedAd();
              },
              child: Obx(
                () => Text(adsController.count.value.toString()),
              ),
            ),




            RepaintBoundary(
                key: cardKey,
                child: Image.asset('assets/images/loading.png', height: 200,)),
          ],
        ),
      ),
    );
  }
}
