import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:launch_review/launch_review.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_page.dart';
import 'package:pa_template/app/modules/history_module/history_page.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/constants/default_card.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/models/card_detail_model.dart';
import 'package:pa_template/models/history_card_model.dart';
import 'package:package_info/package_info.dart';

import 'home_page.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({this.repository});

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
    pages = [
      {'page': MainPage(), 'title': 'Main Screen'},
      {'page': GalleryPage(), 'title': 'Gallery Screen'},
      {'page': HistoryPage(), 'title': 'History Screen'},
    ];
    list.value.addAll([
      {'page': MainPage(), 'title': 'Main Screen'},
      {'page': GalleryPage(), 'title': 'Gallery Screen'},
      {'page': HistoryPage(), 'title': 'History Screen'},
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

// called after the widget is rendered on screen
  @override
  void onReady() {
    super.onReady();
    getPref();
    countOpen();

  }
  

  int openTimes;
  countOpen() async  {
    if (!box.hasData('OPEN_TIMES')) {
      box.write('OPEN_TIMES', 1);
    } else {
      openTimes = box.read('OPEN_TIMES');
      if (openTimes % 3 == 0)  {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        Get.dialog(AlertDialog(
          title: Text('Thank you'),
          content: Text(
              "Would you please rate me? If you need more features, please post your suggestion in review comment!"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel')),
            TextButton(onPressed: () {
              GetPlatform.isAndroid
                  ? LaunchReview.launch(
                  androidAppId: packageInfo.packageName, writeReview: true)
                  : repository.fetchAppInfo(packageInfo.packageName).then((value) => {
                LaunchReview.launch(
                    iOSAppId: '${value.results[0].trackId}',
                    writeReview: true),
              });
              Get.back();
            }, child: Text('Rate')),
          ],
        ));
      }
      box.write('OPEN_TIMES', openTimes+1);
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
      historyCard.value =
          HistoryCardModel(card: cardDetail.value, isUploaded: false, id: id.toString());
      HistoryCardModel tempCard =
          HistoryCardModel.fromJson(historyCard.toJson());

      listHistory.add(tempCard);
      box.write('LIST_HISTORY', listHistory);
      print('a');
    });
  }
}
