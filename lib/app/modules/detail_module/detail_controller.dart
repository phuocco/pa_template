import 'dart:io';
import 'package:archive/archive_io.dart' as archive;
import 'package:flutter_archive/flutter_archive.dart';

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
  final fileNameNoExt = ''.obs;
  final finalPath = ''.obs;
  final filePathDownload = ''.obs;
  final dirPath = ''.obs;
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

  installSkin(String link) async{
    isDownloaded.value = false;
    String newLink = link.split('.png').first + '.mcpack';
    finalPath.value = '$basePath' +'/'+ newLink.split('/').last;
    CancelToken cancelToken = CancelToken();
    ProgressDialog pd = ProgressDialog(context: Get.context);
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
    File file = File(finalPath.value);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    isDownloaded.value = true;
  }
  installAddon(String link) async {
    isDownloaded.value = false;
    fileName.value = link.split('/').last;
    fileNameNoExt.value = fileName.value.split('.').first;
    finalPath.value = '$basePath' +'/'+ fileNameNoExt.value + '.mcaddon';
    CancelToken cancelToken = CancelToken();
    ProgressDialog pd = ProgressDialog(context: Get.context);
    pd.show(max: 100, msg: 'File Downloading...');
    var response = await dio.get(
      link,
      cancelToken: cancelToken,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    pd.close();
    File file = File(finalPath.value);
    print(finalPath.value);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    isDownloaded.value = true;
  }


  installMapSeed(String link) async {
    isDownloaded.value = false;
    fileName.value = link.split('/').last;
    fileNameNoExt.value = fileName.value.split('.').first;
    filePathDownload.value = '$basePath' +'/'+ fileName.value;
    finalPath.value = '$basePath' +'/'+ fileNameNoExt.value + '.mcworld';
    dirPath.value = "$basePath/" + fileNameNoExt.value;
    final sourceDir = Directory(dirPath.value);
    final file = File(filePathDownload.value);

    if(sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if(file.existsSync()) file.deleteSync(recursive: true);

    CancelToken cancelToken = CancelToken();
    ProgressDialog pd = ProgressDialog(context: Get.context);
    pd.show(max: 100, msg: 'File Downloading...');
    var response = await dio.get(
      link,
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
    print(filePathDownload.value);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    try {
      final zipFile = File(filePathDownload.value);
      final destinationDir = Directory("$basePath/" + fileNameNoExt.value);
      print(fileNameNoExt.value);
      print(destinationDir.path);
      final bytes = zipFile.readAsBytesSync();
      final arc = archive.ZipDecoder().decodeBytes(bytes);

      for (final file in arc) {
        final filename = file.name;
        print("$basePath/" + fileNameNoExt.value +'/'+ filename);
        if (file.isFile) {
          final data = file.content as List<int>;
          File("$basePath/" + 'mcpe' +'/'+ filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          destinationDir..create(recursive: true);
        }
      }

      try {
        List folder = [];
        final dir2 = Directory("$basePath/" + "mcpe/");
        if(dir2.existsSync()){
          folder = dir2.listSync();
        }
        final mcWorld = File(finalPath.value);
        await ZipFile.createFromDirectory(
          //  sourceDir: isText ? Directory(dir) : folder[0],
          sourceDir: folder[0],
          zipFile: mcWorld,
          recurseSubDirs: true,
        );
          print('donee');
      } catch (e){
        print(e);
      }

    } catch (e){
      print(e);
    }

    isDownloaded.value = true;


  }


  installTexture(String link) async {
    isDownloaded.value = false;
    fileName.value = link.split('/').last;
    fileNameNoExt.value = fileName.value.split('.').first;
    filePathDownload.value = '$basePath' +'/'+ fileName.value;
    finalPath.value = '$basePath' +'/'+ fileNameNoExt.value + '.mcpack';
    dirPath.value = "$basePath/" + fileNameNoExt.value;
    final sourceDir = Directory(dirPath.value);
    final file = File(filePathDownload.value);

    if(sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if(file.existsSync()) file.deleteSync(recursive: true);

    CancelToken cancelToken = CancelToken();
    ProgressDialog pd = ProgressDialog(context: Get.context);
    pd.show(max: 100, msg: 'File Downloading...');
    var response = await dio.get(
      link,
      cancelToken: cancelToken,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );

    print(finalPath.value);
    print(filePathDownload.value);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    try {
      final zipFile = File(filePathDownload.value);
      final destinationDir = Directory("$basePath/" + 'mcpe');
      print(fileNameNoExt.value);
      print(destinationDir.path);
      final bytes = zipFile.readAsBytesSync();
      final arc = archive.ZipDecoder().decodeBytes(bytes);

      for (final file in arc) {
        final filename = file.name;
        print("$basePath/" + fileNameNoExt.value +'/'+ filename);
        if (file.isFile) {
          final data = file.content as List<int>;
          File("$basePath/" + 'mcpe' +'/'+ filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          destinationDir..create(recursive: true);
        }
      }

      try {
        List folder = [];
        final dir2 = Directory("$basePath/" + "mcpe/");
        if(dir2.existsSync()){
          folder = dir2.listSync();
        }
        final mcPack = File(finalPath.value);
        await ZipFile.createFromDirectory(
          //  sourceDir: isText ? Directory(dir) : folder[0],
          sourceDir: folder[0],
          zipFile: mcPack,
          recurseSubDirs: true,
        );
        print('donee');
        pd.close();
      } catch (e){
        print(e);
      }

    } catch (e){
      print(e);
    }

    isDownloaded.value = true;


  }


  importToMinecraft(String filePath) async {
    await platform.invokeMethod('install', filePath);
    Get.back();
  }

}
