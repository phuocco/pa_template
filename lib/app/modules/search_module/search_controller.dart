import 'package:pa_template/app/data/repository/search_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchController extends GetxController{

  final SearchRepository repository;

  SearchController({this.repository});

  var _searchText = ''.obs;
  set searchText(value) => _searchText.value = value;
  get searchText => _searchText.value;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;


}
