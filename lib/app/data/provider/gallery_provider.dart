import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'http://144.202.7.67:3004/api/UploadItems/getListUploadItem?current_page=1&lim=30&sort_type=0';

class GalleryProvider extends GetConnect {

  // Get request example
  Future<Response> getUser(int id) => get('$baseUrl/users/id');

  // Post request example
  Future<Response> postUser(Map data) => post('$baseUrl/users', data);

  Future getGallery(int sortType) async {
    var url = 'http://144.202.7.67:3004/api/UploadItems/getListUploadItem?current_page=1&lim=30&sort_type=$sortType';
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