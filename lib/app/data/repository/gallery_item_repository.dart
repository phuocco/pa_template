import 'package:pa_template/app/data/provider/gallery_item_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryItemRepository {
  final GalleryItemProvider provider;

  GalleryItemRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

}