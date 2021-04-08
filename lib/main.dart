import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/routes/app_pages.dart';
import 'package:pa_template/app/translations/app_translations.dart';

import 'app/modules/all_binding.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
