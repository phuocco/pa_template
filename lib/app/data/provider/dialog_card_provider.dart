import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:pa_template/constants/const_url.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardProvider extends GetConnect {

   rateCard(String id, double point) async {

    var url = baseAPIUrl + 'api/UploadItems/Vote';
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await httpClient.post(url,
        headers: headers,
        body: json.encode({
          "item_id": id,
          "point": point,
        }));
    if (response.statusCode == 200) {
      print("point on server: " + point.toString());
      return true;
    } else {
      return false;
    }
  }
  reportCard(String id) async {
    var url = baseAPIUrl + 'api/UploadItems/Report';

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await httpClient.post(url, headers: headers, body: {
      "item_id": id,
    });
    if (response.statusCode == 200) {
      print('reported on server');
      return true;
    }
  }
}
