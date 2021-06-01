import 'package:mods_guns/app/data/provider/search_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchRepository {
  final SearchProvider provider;

  SearchRepository({@required this.provider}) : assert(provider != null);

  getSearchItems(String searchText, {bool isFetchNewData = false}) => provider.getSearchItems(searchText,isFetchNewData:isFetchNewData);

}