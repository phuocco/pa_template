import 'dart:io';
import 'package:archive/archive_io.dart' as archive;
import 'package:device_info/device_info.dart';
import 'package:flutter_archive/flutter_archive.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
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
      Directory mcpe = Directory("$basePath/" + "mcpe/");
      if(mcpe.existsSync()) mcpe.deleteSync(recursive: true);
      print(basePath);
    } else if (GetPlatform.isIOS){
      Directory documents = await getApplicationDocumentsDirectory();
      basePath = documents.path;
      Directory mcpe = Directory("$basePath/" + "mcpe/");
      if(mcpe.existsSync()) mcpe.deleteSync(recursive: true);
      print(basePath);
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
    print(finalPath.value);
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
    final mcWorld = File(finalPath.value);

    if(sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if(file.existsSync()) file.deleteSync(recursive: true);
    if (GetPlatform.isIOS) {
      if(mcWorld.existsSync())  mcWorld.deleteSync(recursive: true);
    }
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
      final destinationDir = Directory("$basePath/" + 'mcpe/');
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
        await ZipFile.createFromDirectory(
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
    final mcPack = File(finalPath.value);

    if(sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if(file.existsSync()) file.deleteSync(recursive: true);
    if (GetPlatform.isIOS) {
      if(mcPack.existsSync())  mcPack.deleteSync(recursive: true);
    }
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

        await ZipFile.createFromDirectory(
          sourceDir: folder[0],
          zipFile: mcPack,
          recurseSubDirs: true,
        );
        pd.close();
      } catch (e){
        print(e);
      }

    } catch (e){
      print(e);
    }

    isDownloaded.value = true;


  }

  installMapSeedTexture(String link, bool isTexture) async {
    String extension = isTexture ? '.mcpack' : '.mcworld';

    isDownloaded.value = false;
    fileName.value = link.split('/').last;
    fileNameNoExt.value = fileName.value.split('.').first;
    filePathDownload.value = '$basePath' +'/'+ fileName.value;
    finalPath.value = '$basePath' +'/'+ fileNameNoExt.value + extension;
    dirPath.value = "$basePath/" + fileNameNoExt.value;
    final sourceDir = Directory(dirPath.value);
    final file = File(filePathDownload.value);
    final mcFile = File(finalPath.value);

    if(sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if(file.existsSync()) file.deleteSync(recursive: true);
    if (GetPlatform.isIOS) {
      if(mcFile.existsSync())  mcFile.deleteSync(recursive: true);
    }
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

        await ZipFile.createFromDirectory(
          sourceDir: folder[0],
          zipFile: mcFile,
          recurseSubDirs: true,
        );
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
    if(GetPlatform.isAndroid){
      await platform.invokeMethod('install', filePath);
    } else if (GetPlatform.isIOS){
      var isInstalled = await platform.invokeMethod('install', filePath);
      var is1131 = await platform.invokeMethod('check1331');
      if(isInstalled){
        IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
        var version = iosInfo.systemVersion;
        var arr = version.split(".");
        var currentVersion = arr[0];
        if(is1131){
          OpenFile.open(filePath,uti: "com.mojang.minecraftpe");
         // return true;
        }else{
          if(num.parse(currentVersion)>=13){
            //return "true";
          }else{
            OpenFile.open(filePath,uti: "com.mojang.minecraftpe");
          //  return true;
          }
        }
      }else{
       // return false;
      }
    }
    Get.back();

  }

}
