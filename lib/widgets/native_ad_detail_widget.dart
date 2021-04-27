import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/controllers/native_ad_controller_new.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class NativeAdDetailWidget extends StatelessWidget {
  final controller = Get.put(AdsController());

  // final AdWidget adWidget;
  final Completer<NativeAd> adItem;
  NativeAdDetailWidget({this.adItem});

  @override
  Widget build(BuildContext context) {
    print('build new object');
    return GetBuilder<AdsController>(
      builder: (controller) {
        return FutureBuilder<NativeAd>(
          future: adItem.future,
          builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
            Widget child;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                child = Text('loading');
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  child = AdWidget(ad: snapshot.data);
                } else {
                  child = Text('error');
                }
            }
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kNativeAdBackground
              ),
              width: double.infinity,
              height: 370,
              // color: kNativeAdBackground,
              child: child,
            );
          },
        );
      },
    );
  }
}
