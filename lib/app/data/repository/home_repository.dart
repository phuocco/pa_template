import 'package:mods_guns/app/data/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeRepository {
  final HomeProvider provider;

  HomeRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }
  fetchAppInfo(String packageName){
    return provider.fetchAppInfo(packageName);
  }
}