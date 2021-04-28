import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MainController extends GetxController{

  final MainRepository repository;

  MainController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  final listAddon = <dynamic>[].obs;
  final adsWidget = NativeAdHomeWidget().obs;

  getItems() async {
    return repository.getItem().then((value){
      listAddon.assignAll(value);
      listAddon.insert(0, "Ads");
      listAddon.insert(2, "Ads");
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getItems();
  }
}
