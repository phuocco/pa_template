import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/modules/card_module/view/card_view.dart';
import 'package:pa_template/screens/home_screen.dart';

import 'modules/card_module/view/card_view.dart';
import 'modules/gallery_module/view/gallery_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: HomeScreen(),
        getPages: [
          GetPage(name: '/home', page: () => HomeScreen()),
        ]);
  }
}
