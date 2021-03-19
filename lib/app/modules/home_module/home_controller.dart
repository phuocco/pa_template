import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_page.dart';
import 'package:pa_template/app/modules/history_module/history_page.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/constants/default_card.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';

import 'home_page.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeController extends GetxController{

  final HomeRepository repository;

  HomeController({this.repository});

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


  // giong initState
  // called immediately after the widget is allocated memory
  @override
  void onInit() {
  // TODO: implement onInit
  initPages();
  super.onInit();

  }

// called after the widget is rendered on screen
  @override
  void onReady() {
  // TODO: implement onReady
  super.onReady();
  }

  // giong dispose
  // called just before the Controller is deleted from memory
  @override
  void onClose() {
  // TODO: implement onClose
  super.onClose();
  }

  void initPages(){
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

  Future<void> saveImage(String fileName) async {


    Future cardPathF = UtilFunctions().exportToImage(
        globalKey: cardKey,
        fileName: fileName.toString(),
        isSaveToGallery: true,
        folder: "");
    Future thumbnailPathF =  UtilFunctions().exportToImage(
        globalKey: cardKey,
        fileName: fileName.toString() + '_Thumbnail',
        isSaveToGallery: false,
        folder: '.thumbnail');

    Future.wait([cardPathF, thumbnailPathF]).then((value) {
      cardDetail.value.cardImg = value[0];
    });

  }

  }
