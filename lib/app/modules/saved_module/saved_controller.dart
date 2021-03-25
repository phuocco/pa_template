import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/saved_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
import 'package:pa_template/modules/card_module/card_model/card_model.dart';
import 'package:pa_template/modules/card_module/card_model/history_card_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SavedController extends GetxController {
  final SavedRepository repository;

  SavedController({this.repository});

  final listHistory = <HistoryCardModel>[].obs;
  final box = GetStorage();

  getPref() async {
    if (box.hasData('LIST_HISTORY')) {
      List<HistoryCardModel> tempReport =
      historyCardFromJson(jsonEncode(box.read('LIST_HISTORY')));
      listHistory.assignAll(tempReport);
    }
  }


  uploadCard(HistoryCardModel historyCardModel, int index) {
    getPref();
    historyCardModel.isUploaded
        ? Get.dialog(
            AlertDialog(
              title: Text('This image already uploaded!!'),
              content: Text('You cannot upload again'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('OK'))
              ],
            ),
            barrierDismissible: false)
        : Get.dialog(
            AlertDialog(
              title: Text('Upload card!!'),
              content: Text('Do you want to upload this card?'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Get.back();
                      showUploadingDialog();
                      uploadImageGetLinkNewServer(historyCardModel).then((value) {
                        Get.back();
                        print(value);
                        listHistory[index].isUploaded = true;
                        box.write('LIST_HISTORY', listHistory);
                        Get.dialog(Dialog(child: Text('Success'),));

                      });
                    },
                    child: Text('OK')),
              ],
            ),
            barrierDismissible: false);
  }

  showUploadingDialog() {
    Get.dialog(Center(
      child: SizedBox(
        width: 250.0,
        child: TypewriterAnimatedTextKit(

          text: [
            "Uploading.........",

          ],
          textStyle: TextStyle(
              fontSize: 30.0,
              fontFamily: "Agne"
          ),
          textAlign: TextAlign.start,
        ),
      ),
    ),barrierDismissible: false);
  }

  // uploadFile(File file, String container) async {
  //   String a = '';
  //   a = await repository.uploadFile(file, container);
  //   print(a);
  // }

  Future<CardModel> uploadImageGetLinkNewServer(
      HistoryCardModel historyCardModel) async {
    String urlImage;
    String urlCardPath;
    String urlThumb;

    Future uploadImage() async {
      urlImage = await repository.uploadFile(
          File(historyCardModel.card.cardImg), "MainImage");

      urlCardPath = await repository.uploadFile(
          File(historyCardModel.card.cardImg), "Card");

      urlThumb = await repository.uploadFile(
          File(historyCardModel.card.cardImg), "Thumbnail");
    }

    var upload = uploadImage();
    var futures = [upload];
    var value = await Future.wait(futures).then((value) =>
        print('url ' + urlImage + '\n' + urlCardPath + '\n' + urlThumb));

    HistoryCardModel uploadCard =
        HistoryCardModel.fromJson(historyCardModel.toJson());
    uploadCard.card.cardImg = urlImage;
    uploadCard.card.cardPath = urlCardPath;
    uploadCard.card.thumbUrl = urlThumb;
    CardModel card = await repository.uploadCard(uploadCard.card);
    print(card.id);
    return card;
  }


}
