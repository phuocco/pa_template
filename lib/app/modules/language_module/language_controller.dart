import 'package:flutter/material.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LanguageController extends GetxController{

  LanguageController();

  final languageList = [''].obs;
  final localeCodeList = <Locale>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLanguage();

  }

  initLanguage(){

    languageList.assignAll([
      "English US",
      "Portuguese - Português",
      "Spanish - Español",
      "Japanese - 日本の",
      "Korean - 한국어",
      "German - Deutsche",
      "Russian - Pусский",
      "Thai - ไทย",
      "Turkish - Türk",
      "Vietnamese - Tiếng Việt",
    ]);

    localeCodeList.assignAll([
      Locale('en', 'US'),
      Locale('pt', 'PT'),
      Locale('es', 'ES'),
      Locale('ja', 'JA'),
      Locale('ko', 'KO'),
      Locale('de', 'DE'),
      Locale('ru', 'RU'),
      Locale('th', 'TH'),
      Locale('tr', 'TR'),
      Locale('vi', 'VN'),
    ]);
  }
}
