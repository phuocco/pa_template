import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/history_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/card_module/card_model/history_card_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryController extends GetxController{

  final HistoryRepository repository;

  HistoryController({this.repository});

  final listHistory = <HistoryCardModel>[].obs;
  final box = GetStorage();

  getPref() async {
    if (box.hasData('LIST_HISTORY')) {
      List<HistoryCardModel> tempReport =
      historyCardFromJson(jsonEncode(box.read('LIST_HISTORY')));
      listHistory.assignAll(tempReport);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPref();
  }

}
