import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mods_guns/app/routes/app_pages.dart';
import 'package:mods_guns/app/translations/app_translations.dart';

import 'app/modules/all_binding.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await GetStorage.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Guns Mod - Weapons Addon for MCPE',
      debugShowCheckedModeBanner: false,
      locale: AppTranslation.locale,
      fallbackLocale: AppTranslation.fallbackLocale,
      translations: AppTranslation(), // translations will be displayed in that locale
      getPages: AppPages.pages,
      initialBinding: AllBinding(),
      initialRoute: '/home',
    );
  }
}
