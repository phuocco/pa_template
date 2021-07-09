import 'package:flutter/cupertino.dart';
import 'package:mods_guns/app/data/repository/search_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/models/addons_item.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchController extends GetxController{

  final SearchRepository repository;

  SearchController({this.repository});

  var _searchText = ''.obs;
  set searchText(value) => _searchText.value = value;
  get searchText => _searchText.value;



  final listAddonSearch = <AddonsItem>[].obs;
  final listAddonSearchWithAds = <dynamic>[].obs;


  getSearchItems(BuildContext context, String searchText) async {

    if(context.isPhone){
      return repository.getSearchItems(searchText).then((value){
        listAddonSearch.assignAll(value);
        listAddonSearchWithAds.assignAll(value);
        for (var i = 2; i < listAddonSearchWithAds.length; i += 5) {
          listAddonSearchWithAds.insert(i, 'Ads');
        }
      });
    } else {
      return repository.getSearchItems(searchText).then((value){
        listAddonSearch.assignAll(value);
        listAddonSearchWithAds.assignAll(value);

        for (var i = 2; i < listAddonSearchWithAds.length; i += 11) {
          listAddonSearchWithAds.insert(i, 'Ads');
        }
      });
    }
  }
}
