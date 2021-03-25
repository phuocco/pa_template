import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:pa_template/models/gallery_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */


class GalleryProvider extends GetConnect {



  Future getGallery(int page, int sortType) async {
    var url = 'http://144.202.7.67:3004/api/UploadItems/getListUploadItem?current_page=$page&lim=30&sort_type=$sortType';
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var data = response.bodyString;
      var decodedData = galleryCardFromJson(data);
      print(response.statusCode);
      return decodedData;
    } else {
      print('error' + response.statusCode.toString());
      return galleryCardFromJson("[]");
    }
  }
}