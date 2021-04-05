import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/constants/const_drawer.dart';

import '../controllers/ads_controller.dart';
import '../functions/util_functions.dart';

class BaseNative extends StatelessWidget {

  final controller = Get.put(AdsController());

  final AdWidget adWidget;
  final Completer completer;
  BaseNative({this.adWidget, this.completer});

  @override
  Widget build(BuildContext context) {
    print('build new object');
    return  GetBuilder<AdsController>(
      builder: (controller) {
        print("count 1 rebuild");
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
              width: 250,
              height: 350,
              color: Colors.blueGrey,
              child: child,
            );
          },
        );
      },
    );
  }
}
