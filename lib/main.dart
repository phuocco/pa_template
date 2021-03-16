import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/home_module/home_bindings.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/app/routes/app_pages.dart';

import 'app/modules/all_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
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
    //  home: HomePage(),
      getPages: AppPages.pages,
      initialBinding: AllBinding(),
      initialRoute: '/home',
    );
  }
}
