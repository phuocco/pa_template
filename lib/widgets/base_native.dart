import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/constants/const_drawer.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class NativeAdHomeWidget extends StatelessWidget {
  final controller = Get.put(AdsController());

  final AdWidget adWidget;
  final Completer completer;
  NativeAdHomeWidget({this.adWidget, this.completer});

  @override
  Widget build(BuildContext context) {
    print('build new object');
    return GetBuilder<AdsController>(
      builder: (controller) {
        return FutureBuilder<NativeAd>(
          future: completer.future,
          builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
            Widget child;

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                child = Container();
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  child = adWidget;
                } else {
                  child = Text('Error loading $NativeAd');
                }
            }
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kNativeAdBackground
              ),
              width: double.infinity,
              height: 350,
              // color: kNativeAdBackground,
              child: child,
            );
          },
        );
      },
    );
  }
}
