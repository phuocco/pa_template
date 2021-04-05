import 'package:get/get_connect/connect.dart';
import 'package:pa_template/constants/const_url.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'http://youapi';

class HistoryProvider extends GetConnect {

  // Get request example
  Future<Response> getUser(int id) => get('$baseUrl/users/id');

  // Post request example
  Future<Response> postUser(Map data) => post('$baseUrl/users', data);

   deleteCard(String id) async {
     var url = deleteCardUrl + id;
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    var response = await httpClient.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      return false;
    }
  }

}