import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mods_guns/purchase_screen.dart';
class TestNativePage extends StatefulWidget {
  @override
  _TestNativePageState createState() => _TestNativePageState();
}

class _TestNativePageState extends State<TestNativePage> {


  NativeAd nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nativeAd = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      request: AdRequest(),
      factoryId: 'adFactoryId',
      customOptions: <String, Object>{
        'type': 'NativeAdHome',
      },
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$NativeAd failedToLoad: $error');
          nativeAdCompleter.completeError(error);
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    );
    // nativeAd.customOptions.
    Future<void>.delayed(Duration(seconds: 1), () => nativeAd.load());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder<NativeAd>(
            future: nativeAdCompleter.future,
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
                    child = AdWidget(ad: nativeAd);
                  } else {
                    child = Text('Error loading $NativeAd');
                  }
              }

              return Container(
                width: double.infinity,
                height: 350,
                color: Colors.blueGrey,
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
