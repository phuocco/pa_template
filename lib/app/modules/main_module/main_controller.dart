
import 'package:flutter/material.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/native_ad_controller_new.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';


class MainController extends GetxController{

  final MainRepository repository;

  MainController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  final listAddon = <dynamic>[].obs;
  final adsWidget = NativeAdHomeWidget().obs;

  getItems(BuildContext context) async {
    if(context.isPhone){
      return repository.getItem().then((value){
        listAddon.assignAll(value);
        for (var i = 2; i < listAddon.length; i += 5) {
          listAddon.insert(i, 'Ads');
        }
      });
    } else {
      return repository.getItem().then((value){
        listAddon.assignAll(value);
        for (var i = 2; i < listAddon.length; i += 11) {
          listAddon.insert(i, 'Ads');
        }
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getItems(Get.context);
  }
}
