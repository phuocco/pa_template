import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pa_template/app/data/repository/detail_repository.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class DetailController extends GetxController{

  final DetailRepository repository;
  DetailController({this.repository});

  static const platform = MethodChannel('addons/detail');

  String basePath = '';
  final fileName = ''.obs;
  final finalPath = ''.obs;
  var dio = new Dio();
  final isDownloaded =  false.obs;
  initBasePath() async {
    if(GetPlatform.isAndroid){
      Directory appDocDirAndroid = await getExternalStorageDirectory();
      basePath = appDocDirAndroid.path;
      print(basePath);
    } else if (GetPlatform.isIOS){
      Directory documents = await getApplicationDocumentsDirectory();
      basePath = documents.path;
    }
  }

  @override
  void onInit() {

    initBasePath();
    print('init..');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  installSkin(String link, BuildContext context) async{
    String newLink = link.split('.png').first + '.mcpack';
    finalPath.value = '$basePath' +'/'+ newLink.split('/').last;
    CancelToken cancelToken = CancelToken();
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'File Downloading...');

    var response = await dio.get(
      newLink,
      cancelToken: cancelToken,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    pd.close();
    print(finalPath.value);
    File file = File(finalPath.value);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    isDownloaded.value = true;

  }

  importToMinecraft(String filePath) async {
    await platform.invokeMethod('install', filePath);
  }

}
