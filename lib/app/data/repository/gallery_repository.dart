import 'package:pa_template/app/data/provider/gallery_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryRepository {
  final GalleryProvider provider;

  GalleryRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

}