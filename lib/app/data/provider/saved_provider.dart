import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
import 'package:pa_template/modules/card_module/card_model/card_model.dart';
import 'package:pa_template/modules/card_module/card_model/history_card_model.dart';
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';
import 'package:pa_template/utils/models/base_gallery_card.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'http://youapi';

class SavedProvider extends GetConnect {
  // Get request example
  Future<Response> getUser(int id) => get('$baseUrl/users/id');

  // Post request example
  Future<Response> postUser(Map data) => post('$baseUrl/users', data);

  //* upload file
  Future uploadFile(File file, String container) async {

    String urlAddon;
    final form = FormData({
      'files': MultipartFile(file, filename: file.path.split('/').last),
    });
    var responded =
        httpClient.post(uploadUrl + container + '/upload', body: form);
    if (responded != null) {
      urlAddon =
          uploadUrl + container + "/download/" + file.path.split('/').last;
    }
    return urlAddon;
  }

  //upload card
   uploadCard(CardDetailModel cardModel) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    Map nonNullYugi = cardModel.toJson();
    var entries = cardModel.toJson().entries.toList();
    for (var entry in entries) {
      if (entry.value == null) {
        nonNullYugi.remove(entry.key);
      }
    }
    Map body = {"card": nonNullYugi};

    // dio.Dio dioP = new dio.Dio();
    // dio.Response<String> response =
    // await dioP.post<String>(url, data: body).catchError((error) {
    //   print("dio fail");
    //   return null;
    // });
    
    var responded =await  httpClient.post(uploadCardUrl,body: body).catchError((error){
       print('fail');
      return null;
    });
    
    if (responded == null) {
      print('response null, failed');
      return null;
    }



    if(responded.statusCode == 200){
      var data = responded.body;
      var decodedData = CardModel.fromJson(data);
      print(decodedData);
      return decodedData;

    } else {
      print('failed');
      return null;
    }


  }
}
