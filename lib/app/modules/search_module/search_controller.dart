import 'package:flutter/cupertino.dart';
import 'package:pa_template/app/data/repository/search_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/models/addons_item.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchController extends GetxController{

  final SearchRepository repository;

  SearchController({this.repository});

  var _searchText = ''.obs;
  set searchText(value) => _searchText.value = value;
  get searchText => _searchText.value;



  final listAddon = <AddonsItem>[].obs;


  getSearchItems(BuildContext context, String searchText) async {
    print(searchText);
    if(context.isPhone){
      return repository.getSearchItems(searchText).then((value){
        listAddon.assignAll(value);
        // for (var i = 2; i < listAddon.length; i += 5) {
        //   listAddon.insert(i, 'Ads');
        // }
      });
    } else {
      return repository.getSearchItems(searchText).then((value){
        listAddon.assignAll(value);

        // for (var i = 2; i < listAddon.length; i += 11) {
        //   listAddon.insert(i, 'Ads');
        // }
      });
    }
  }
}
