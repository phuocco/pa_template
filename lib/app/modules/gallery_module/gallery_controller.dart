import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/models/gallery_model.dart';


class GalleryController extends GetxController with SingleGetTickerProviderMixin{

  final GalleryRepository repository;

  GalleryController({this.repository});
  TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  final _listCardNewest = <GalleryModel>[].obs;
  get listCardNewest => _listCardNewest;
  final _listCardRating = <GalleryModel>[].obs;
  get listCardRating => _listCardRating;
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

  getGallery(int page,int type) {

    type == 0 ? repository.getGallery(page,0).then((data){
      _listCardNewest.addAll(data);
    }) : repository.getGallery(page,1).then((data){
      _listCardRating.addAll(data);
    });
  }

  refreshGallery(int type){
    type == 0 ? _listCardNewest.assignAll([]) : _listCardRating.assignAll([]);
  }

}
