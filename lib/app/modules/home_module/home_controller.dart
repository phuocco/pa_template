import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/about_module/about_page.dart';
import 'package:pa_template/app/modules/language_module/language_page.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/app/modules/question_module/question_page.dart';
import 'package:pa_template/app/modules/submit_module/submit_page.dart';
import 'package:pa_template/app/modules/tutorial_module/tutorial_page.dart';
import 'package:pa_template/constants/default_card.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/models/downloaded_item_model.dart';
import 'package:pa_template/models/history_card_model.dart';
import 'package:pa_template/utils/services/remove_config_service.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'home_page.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({this.repository});
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  final box = GetStorage();

  final cardDetail = defaultCard.obs;
  final selectingPage = 0.obs;
  final fileName = ''.obs;
  Offset center = Offset(0, 0);
  double radius = 30.0;
  bool enabled = false;
  Widget description = Container();

  List<Map<String, Object>> pages;
  final text = "aaa".obs;

  final list = Rx<List<Map<String, Object>>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    initPages();

    super.onInit();
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
      // {'page': GalleryPage(), 'title': 'Gallery Screen'},
      // {'page': HistoryPage(), 'title': 'History Screen'},
    ]);
  }

  void selectPage(int id) {
    selectingPage.value = id;
    update();
  }

  void changeText() => text.value = "bbb";

  final listHistory = <HistoryCardModel>[].obs;
  getPref() async {
    if (box.hasData('LIST_HISTORY')) {
      List<HistoryCardModel> tempReport =
          historyCardFromJson(jsonEncode(box.read('LIST_HISTORY')));
      listHistory.assignAll(tempReport);
    }
  }

  final listDownloaded = <DownloadedItemModel>[].obs;

  getPrefDownloaded() async {
    if (box.hasData('LIST_DOWNLOADED')) {
      List<DownloadedItemModel> tempDownload =
          downloadedItemFromJson(jsonEncode(box.read('LIST_DOWNLOADED')));
      listDownloaded.assignAll(tempDownload);
    }
  }

// called after the widget is rendered on screen
  @override
  void onReady() {
    super.onReady();
    getPref();
    countOpen();
    // checkUpdate();
  }

  checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var versionInApp = packageInfo.buildNumber;
    var versionRemote = "";
    Map<String, RemoteConfigValue> maps =
        await RemoteConfigService.getConfigAppVersion();
    GetPlatform.isAndroid
        ? versionRemote = maps["versionCode"].asString()
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
        PACoreGetX().countOpen(packageName);
        // LaunchReview.launch(iOSAppId: packageName, writeReview: true);
      });
    }
  }
  DownloadedItemModel downloadedItemModel;

  savePrefDownloadedItem(String id, String pathFile) async {
    downloadedItemModel = DownloadedItemModel(id: id, pathFile: pathFile);
    listDownloaded.add(downloadedItemModel);
    box.write("LIST_DOWNLOADED", listDownloaded);
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
