import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/favorite_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/models/addons_item.dart';
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
  // getList(List<AddonsItem> list){
  //   listAddon.assignAll(list);
  //   print("abc "+listAddon.length.toString());
  //   print("abc "+listFavoriteAddon.length.toString());
  // }
  // getFavoriteList(List<AddonsItem> list){
  //   listFavoriteAddon.assignAll(list);
  //   print("abc :"+listAddon.length.toString());
  //   print("abc :"+listFavoriteAddon.length.toString());
  // }


  // addFavoriteItem(AddonsItem addonsItem){
  //   if(listFavoriteAddon.contains(addonsItem)){
  //     listFavoriteAddon.remove(addonsItem);
  //   } else {
  //     listFavoriteAddon.add(addonsItem);
  //   }
  // }



}
