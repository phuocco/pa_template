
import 'dart:ui';

import 'package:get/get.dart';

import 'en_us_translations.dart';
import 'vi_vn_translations.dart';


class AppTranslation extends Translations{
  static final locale = Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': enUs,
    'vi_VN': viVn,
  };
}