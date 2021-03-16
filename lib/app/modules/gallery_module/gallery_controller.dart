import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryController extends GetxController with SingleGetTickerProviderMixin{

  final GalleryRepository repository;

  GalleryController({this.repository});
  TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  final _listCard = <GalleryModel>[].obs;
  get listCard => _listCard;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  getGallery(int sortType) {
    repository.getGallery(sortType).then((data){
      _listCard.assignAll(data);
    });
  }

}
