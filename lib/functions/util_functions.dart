import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:path_provider/path_provider.dart';

class UtilFunctions {
  double getHeightBanner() {
    //check isPremium;
    double height = Get.height;

    if (GetPlatform.isAndroid) {
      if (Get.height < 420) {
        height = 32;
      } else if (Get.height > 420 && Get.height <= 720) {
        height = 50;
      } else {
        height = 92;
      }
      return height;
    } else {
      return 92;
    }
  }

  Future<void> captureToShare() async{
    RenderRepaintBoundary boundary =
    cardKey.currentContext.findRenderObject();
    double devicePixelRatio = Get.context.devicePixelRatio;
    ui.Image image = await boundary.toImage(pixelRatio: devicePixelRatio);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);
    return pngBytes;
  }

  Future<void> exportToImage(
      {GlobalKey globalKey,
      String fileName,
      bool isSaveToGallery,
      String folder}) async {
    try {
      String filePath;
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      double devicePixelRatio = Get.context.devicePixelRatio;
      ui.Image image = await boundary.toImage(pixelRatio: folder == '.thumbnail' ? 0.35 : devicePixelRatio);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      filePath = await createImageFromBase64(
          base64: bs64,
          fileName: fileName,
          isSaveToGallery: isSaveToGallery,
          folder: folder);
      return filePath;
    } catch (e) {
      print(e);
    }
  }

  Future<String> createImageFromBase64(
      {String base64,
      String fileName,
      bool isSaveToGallery,
      String folder}) async {
    Uint8List bytes = base64Decode(base64);
    String path = '';

    if (GetPlatform.isAndroid) {
      Directory result = await getExternalStorageDirectory();
      Directory newDir;
      folder == '.thumbnail' ? newDir = Directory(result.path + '/thumbnail') : newDir = result;

      if (!newDir.existsSync()) {
        await newDir.create();
      }
      path = newDir.path;

    } else if (GetPlatform.isIOS) {
      Directory result = await getApplicationDocumentsDirectory();
      if (!result.existsSync()) {
        await result.create();
      }
      path = result.path;
    }
    String fullPath = '$path/' + fileName + '.png';
    File file = File(fullPath);
    bool check = await file.exists();
    if (check) await file.delete();
    await file.writeAsBytes(bytes);
    bool isSavedToGallery =
        await GallerySaver.saveImage(file.path, albumName: 'Yugi');

    return file.path;
  }
}
