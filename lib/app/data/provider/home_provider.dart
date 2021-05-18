import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:pa_template/models/more_apps.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'http://youapi';

class HomeProvider extends GetConnect {
  // Get request example
  Future<Response> getUser(int id) => get('$baseUrl/users/id');

  // Post request example
  Future<Response> postUser(Map data) => post('$baseUrl/users', data);

  fetchAppInfo(String packageName) async {
    final response = await httpClient.get('http://itunes.apple.com/lookup?bundleId=' + packageName);

    if (response.statusCode == 200) {
      print(response.statusCode);
      return IosAppInfo.fromJson(jsonDecode(response.bodyString));
    } else {
      throw Exception('Failed to load app');
    }
  }
}
