
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/native_ad_controller_new.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/models/downloaded_item_model.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';


class MainController extends GetxController{

  final MainRepository repository;
  MainController({this.repository});
  final box = GetStorage();
  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  final listAddon = <dynamic>[].obs;


  final adsWidget = NativeAdHomeWidget().obs;
  final isFavoritePage = false.obs;

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
    getPrefDownloaded();
    getPrefFavorite();
  }

  final listDownloaded = <DownloadedItemModel>[].obs;

  getPrefDownloaded() async {
    if (box.hasData('LIST_DOWNLOADED')) {
      List<DownloadedItemModel> tempDownload =
      downloadedItemFromJson(jsonEncode(box.read('LIST_DOWNLOADED')));
      listDownloaded.assignAll(tempDownload);
    }
  }
  DownloadedItemModel downloadedItemModel;

  savePrefDownloadedItem(String id, String pathFile) async {
    downloadedItemModel = DownloadedItemModel(id: id, pathFile: pathFile);
    listDownloaded.add(downloadedItemModel);
    box.write("LIST_DOWNLOADED", listDownloaded);
  }

  final listFavorite = <AddonsItem>[].obs;

  getPrefFavorite() async {
    if(box.hasData('LIST_FAVORITE')){
      List<AddonsItem> tempFavorite = addonsItemFromJson(jsonEncode(box.read('LIST_FAVORITE')));
      listFavorite.assignAll(tempFavorite);
    }
  }
  savePrefFavoriteItem(AddonsItem addonsItem){
    if(listFavorite.contains(addonsItem)){
      listFavorite.remove(addonsItem);
    } else {
      listFavorite.add(addonsItem);
    }
    box.write('LIST_FAVORITE', listFavorite);

  }

  updateAddonItemInList(int index, String pathUrl){
    listAddon[index].isDownloaded = true;
    listAddon[index].pathUrl = pathUrl;
  }
}
