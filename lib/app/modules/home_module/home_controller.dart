import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:mods_guns/app/data/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/about_module/about_page.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_page.dart';
import 'package:mods_guns/app/modules/language_module/language_page.dart';
import 'package:mods_guns/app/modules/main_module/main_page.dart';
import 'package:mods_guns/app/modules/more_apps_module/more_apps_page.dart';
import 'package:mods_guns/app/modules/question_module/question_page.dart';
import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_page.dart';
import 'package:mods_guns/app/modules/submit_module/submit_page.dart';
import 'package:mods_guns/app/modules/tutorial_module/tutorial_page.dart';
import 'package:mods_guns/constants/default_card.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'package:mods_guns/functions/util_functions.dart';
import 'package:mods_guns/models/downloaded_item_model.dart';
import 'package:mods_guns/models/history_card_model.dart';
import 'package:mods_guns/utils/services/remote_config_service.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({this.repository});
  SearchController searchController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchTextEditingController;
  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  final box = GetStorage();

  final cardDetail = defaultCard.obs;
  final selectingPage = 0.obs;
  final selectingPageNew = 'Main Page'.obs;



  final fileName = ''.obs;
  Offset center = Offset(0, 0);
  double radius = 30.0;
  bool enabled = false;
  Widget description = Container();
  final listPages = <String, Object>{}.obs;

  final list = Rx<List<Map<String, Object>>>([]);

  @override
  void onInit()  {
    // TODO: implement onInit
    super.onInit();
    countOpen();


    initPages();
    searchTextEditingController = TextEditingController();
    if (box.hasData('LOCALE')) {
      Get.updateLocale(Locale(box.read("LOCALE")));
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void initPages() {
    list.value.addAll([
      {'page': MainPage(), 'title': 'Main Screen'},
      {'page': LanguagePage(), 'title': 'Language Screen'},
      {'page': TutorialPage(), 'title': 'Tutorial Screen'},
      {'page': QuestionPage(), 'title': 'Question Screen'},
      {'page': SubmitPage(), 'title': 'Submit Screen'},
      {'page': AboutPage(), 'title': 'About Screen'},
      {'page': MoreAppsPage(), 'title': 'More App Screen'},
      {'page': FavoritePage(), 'title': 'Favorite Screen'},
    ]);
    listPages.addAll({
      'Main Page': MainPage(),
      'Language Page': LanguagePage(),
      'Tutorial Page': TutorialPage(),
      'Question Page': QuestionPage(),
      'Submit Page': SubmitPage(),
      'About Page': AboutPage(),
      'More App Page': MoreAppsPage(),
      'Favorite Page': FavoritePage(),
      'Search Page' :SearchPage(),
    });
  }

  void selectPage(int id) {
    selectingPage.value = id;
    update();
  }

  void selectPageNew(String string) {
    selectingPageNew.value = string;
    update();
  }

  final listHistory = <HistoryCardModel>[].obs;
  getPref() async {
    if (box.hasData('LIST_HISTORY')) {
      List<HistoryCardModel> tempReport =
          historyCardFromJson(jsonEncode(box.read('LIST_HISTORY')));
      listHistory.assignAll(tempReport);
    }
  }

// called after the widget is rendered on screen
  @override
  void onReady() async {
    super.onReady();
    getPref();
    await checkUpdate();
    await getTimeOpenInterAd();

  }
  getTimeOpenInterAd() async {
    String timeOpen = await RemoteConfigService.getTimeOpenInterAd();
   box.write('TIME_OPEN', int.parse(timeOpen));

  }

  checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var versionInApp = packageInfo.buildNumber;
    var versionRemote = "";
    Map<String, RemoteConfigValue> maps =
        await RemoteConfigService.getConfigAppVersion();
    GetPlatform.isAndroid
        ? versionRemote = maps["version_code"].asString()
        : versionRemote = maps["build_code_ios"].asString();
    PACoreGetX().checkUpdate(int.parse(versionRemote), int.parse(versionInApp),
        packageInfo.packageName, packageName);
  }

  String packageName;
  countOpen() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (GetPlatform.isAndroid) {
      packageName = packageInfo.packageName;
      PACoreGetX().countOpen(packageName);
    } else {
      repository.fetchAppInfo(packageInfo.packageName).then((value) {
        packageName = value.results[0].trackId.toString();
        // LaunchReview.launch(iOSAppId: packageName, writeReview: true);
      });
     PACoreGetX().countOpen(packageName);
    }
  }

  final historyCard = HistoryCardModel(card: defaultCard).obs;

  Future<void> saveImage(String fileName) async {
    Future cardPathF = UtilFunctions().exportToImage(
        globalKey: cardKey,
        fileName: fileName.toString(),
        isSaveToGallery: true,
        folder: "");
    Future thumbnailPathF = UtilFunctions().exportToImage(
        globalKey: cardKey,
        fileName: fileName.toString() + '_Thumbnail',
        isSaveToGallery: false,
        folder: '.thumbnail');

    Future.wait([cardPathF, thumbnailPathF]).then((value) {
      cardDetail.value.cardImg = value[0];
      cardDetail.value.thumbUrl = value[1];
      int id = DateTime.now().millisecondsSinceEpoch;
      historyCard.value = HistoryCardModel(
          card: cardDetail.value, isUploaded: false, id: id.toString());
      HistoryCardModel tempCard =
          HistoryCardModel.fromJson(historyCard.toJson());

      listHistory.add(tempCard);
      box.write('LIST_HISTORY', listHistory);
      print('a');
    });
  }
}
