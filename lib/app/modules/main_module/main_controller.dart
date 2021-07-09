
import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mods_guns/app/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_page.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_controller.dart';
import 'package:mods_guns/app/modules/language_module/language_page.dart';
import 'package:mods_guns/app/modules/main_module/main_page.dart';
import 'package:mods_guns/app/modules/question_module/question_page.dart';
import 'package:mods_guns/app/modules/search_module/search_page.dart';
import 'package:mods_guns/app/modules/tutorial_module/tutorial_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'package:mods_guns/models/addons_item.dart';
import 'package:mods_guns/models/downloaded_item_model.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';


class MainController extends GetxController{

  final MainRepository repository;
  MainController({this.repository});
  final box = GetStorage();

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  var _countInterAd = 0.obs;
  get countInterAd => _countInterAd.value;
  set countInterAd(value) => _countInterAd.value = value;

  final listAddon = <dynamic>[].obs;
  final listAddonNew = <dynamic>[].obs;


  final adsWidget = NativeAdHomeWidget().obs;
  final isFavoritePage = false.obs;

  getItems(BuildContext context) async {
    if(context.isPhone){
      return repository.getItem().then((value){

        value.sort((a, b) => int.parse(b.downloadCount).compareTo(int.parse(a.downloadCount)));
        listAddon.assignAll(value);
        for (var i = 3; i < listAddon.length; i += 5) {
          listAddon.insert(i, 'Ads');
        }
        value.sort((a, b) => b.createTime.toString().compareTo(a.createTime.toString()));
        listAddonNew.assignAll(value);
        for (var i = 3; i < listAddonNew.length; i += 5) {
          listAddonNew.insert(i, 'Ads');
        }

      });
    } else {
      return repository.getItem().then((value){
        value.sort((a, b) => int.parse(b.downloadCount).compareTo(int.parse(a.downloadCount)));
        listAddon.assignAll(value);
        for (var i = 2; i < listAddon.length; i += 11) {
          listAddon.insert(i, 'Ads');
        }
        value.sort((a, b) => b.createTime.toString().compareTo(a.createTime.toString()));
        listAddonNew.assignAll(value);
        for (var i = 3; i < listAddonNew.length; i += 5) {
          listAddonNew.insert(i, 'Ads');
        }
      });
    }
  }

  var indexStack = 0.obs;
  setIndexStack(int index){
    indexStack.value = index;
    update();
  }

  final selectingPageNew2 = 'Search Page'.obs;
  final listPages2 = <String, Object>{}.obs;

  initPage2() {
    listPages2.addAll({
      'Main Page Download': MainPageDownload(),
      'Main Page ItemId': MainPageItemId(),
      'Search Page': SearchPage(),
      'Downloaded Page': DownloadedPage(),
    });
  }
  void selectPageNew2(String string) {
    selectingPageNew2.value = string;
    update();
  }


  @override
  void onReady() {
    super.onReady();
    initPage2();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getItems(Get.context);
    getPrefDownloaded();
    getPrefFavorite();
    checkConnection();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        if(!isConnecting.value){
          Fluttertoast.showToast(
              msg: "You are connected to the internet",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: kColorAppbar,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        isConnecting.value = true;
      } else if (result == ConnectivityResult.none) {
        Fluttertoast.showToast(
            msg: "You are not connected to the internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        isConnecting.value = false;
      }
    });
  }


  @override
  void onClose() {
    super.onClose();
    connectivitySubscription.cancel();
  }

  StreamSubscription<ConnectivityResult> connectivitySubscription;
  var isConnecting = true.obs;

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      isConnecting.value = true;
    } else if (connectivityResult == ConnectivityResult.none) {
      isConnecting.value = false;
    }
  }
  DownloadedItemModel downloadedItemModel;
  final listDownloaded = <DownloadedItemModel>[].obs;
  final listDownloadedNew = <AddonsItem>[].obs;

  getPrefDownloaded() async {
    if (box.hasData('LIST_DOWNLOADED')) {
      List<DownloadedItemModel> tempDownload =
      downloadedItemFromJson(jsonEncode(box.read('LIST_DOWNLOADED')));
      listDownloaded.assignAll(tempDownload);

      List<AddonsItem> tempDownloadNew =
      addonsItemFromJson(jsonEncode(box.read('LIST_DOWNLOADEDNEW')));
      listDownloadedNew.assignAll(tempDownloadNew);
    }
  }

  savePrefDownloadedItem(AddonsItem addonsItem, String id, String pathFile) async {
    downloadedItemModel = DownloadedItemModel(id: id, pathFile: pathFile);
    listDownloaded.add(downloadedItemModel);
    addonsItem.pathUrl = pathFile;
    listDownloadedNew.add(addonsItem);
    box.write("LIST_DOWNLOADEDNEW", listDownloadedNew);
    box.write("LIST_DOWNLOADED", listDownloaded);
  }

  final listFavorite = <AddonsItem>[].obs;
  final listFavoriteWithAds = <dynamic>[].obs;
  getPrefFavorite() async {
    if(box.hasData('LIST_FAVORITE')){
      List<AddonsItem> tempFavorite = addonsItemFromJson(jsonEncode(box.read('LIST_FAVORITE')));
      listFavorite.assignAll(tempFavorite);
      listFavoriteWithAds.assignAll(tempFavorite);
      for (var i = 2; i < listFavoriteWithAds.length; i += 5) {
        listFavoriteWithAds.insert(i, 'Ads');
      }
    }
  }
  savePrefFavoriteItem(AddonsItem addonsItem){
    // if(listFavorite.contains(addonsItem)){
    //   listFavorite.remove(addonsItem);
    // } else {
    //   listFavorite.add(addonsItem);
    // }
    int count=0;
    listFavorite.forEach((element) {
      if(element.itemId == addonsItem.itemId)
        count++;
    });
    if(count>0){
      listFavorite.remove(addonsItem);
    } else {
      listFavorite.add(addonsItem);
    }


    listFavoriteWithAds.assignAll(listFavorite);
    for (var i = 2; i < listFavoriteWithAds.length; i += 5) {
      listFavoriteWithAds.insert(i, 'Ads');
    }
    listFavoriteWithAds.refresh();
    box.write('LIST_FAVORITE', listFavorite);

  }

  updateAddonItemInList(int index, String pathUrl){
    listAddon[index].isDownloaded = true;
    listAddon[index].pathUrl = pathUrl;
  }
}
