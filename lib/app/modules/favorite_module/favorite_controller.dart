import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:mods_guns/app/data/repository/favorite_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/models/addons_item.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class FavoriteController extends GetxController{

  final FavoriteRepository repository;

  FavoriteController({this.repository});

  final box = GetStorage();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
