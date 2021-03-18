import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';

class SavedPage extends StatelessWidget {
  final adsController = Get.put(AdsController());
  final SavedController savedController = Get.put(SavedController());

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: adsController.myNativeAd);
    print('build saved');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('App name'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 35,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextButton(
                  onPressed: () {
                    adsController.showIntersAds();
                    Get.back();
                  },
                  child: Text(savedController.obj),
                ),
              ),
            ]),
          ),
          TextButton(
                onPressed: () {
                  adsController.requestPurchase(adsController.items[0]);
                  // print(adsController.items.toString());
                },

                child: Text('buy')),

          TextButton(
              onPressed: () {
                adsController.getPurchaseHistory();
                print(adsController.purchases.toString());

              },
              child: Text('get purchased')),
          TextButton(onPressed: adsController.purchased, child: Text('fake purchased')),
          TextButton(onPressed:() => Get.back(), child: Text('back')),

          // GetX<AdsController>(
          //   builder: (adsController) {
          //     return FutureBuilder<NativeAd>(
          //       future: adsController.nativeAdCompleter.value.future,
          //       builder:
          //           (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
          //         Widget child;
          //
          //         switch (snapshot.connectionState) {
          //           case ConnectionState.none:
          //           case ConnectionState.waiting:
          //           case ConnectionState.active:
          //             child = Container();
          //             break;
          //           case ConnectionState.done:
          //             if (snapshot.hasData) {
          //               child = adWidget;
          //             } else {
          //               child = Text('Error loading $NativeAd');
          //             }
          //         }
          //
          //         return Container(
          //           width: Get.width,
          //           height: 200,
          //           child: child,
          //           color: Colors.blueGrey,
          //         );
          //       },
          //     );
          //   },
          // )
        ],
      ),
    ));
  }
}
