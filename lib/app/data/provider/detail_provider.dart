import 'dart:io';

import 'package:dio/dio.dart' ;
import 'package:get/get_connect/connect.dart' hide Response;
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'http://youapi';

class DetailProvider extends GetConnect {
  Dio dio = Dio();

  Future downloadFile(String filePath, String urlDownload) async {
    try {
      Response response = await dio.get(
        urlDownload,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      File file = File(filePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return true;
    } catch (e) {
      print(e);
    }
  }
}
