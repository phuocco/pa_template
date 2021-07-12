import 'package:mods_guns/app/data/provider/creator_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorRepository {
  final CreatorProvider provider;

  CreatorRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

}