
import 'dart:ui';

import 'package:get/get.dart';
import 'package:pa_template/app/translations/ja_japan_translations.dart';
import 'package:pa_template/app/translations/ko_korean_translations.dart';
import 'package:pa_template/app/translations/pt_portugues_translations.dart';
import 'package:pa_template/app/translations/ru_rusian_translations.dart';
import 'package:pa_template/app/translations/th_thai_translations.dart';
import 'package:pa_template/app/translations/tr_turkish_translations.dart';

import 'de_germany_translations.dart';
import 'en_us_translations.dart';
import 'es_spanish_translations.dart';
import 'vi_vn_translations.dart';


class AppTranslation extends Translations{
  static final locale = Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': enUs,
    'de_DE': deDe,
    'es_ES': esEs,
    'ja_JA': jaJa,
    'ko_KO': koKo,
    'pt_PT': ptPt,
    'ru_RU': ruRu,
    'th_TH': thTh,
    'tr_TR': trTr,
    'vi_VN': viVn,

  };
}