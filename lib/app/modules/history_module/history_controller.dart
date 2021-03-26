import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/data/repository/history_repository.dart';
import 'package:get/get.dart';


class HistoryController extends GetxController{

  final HistoryRepository repository;

  HistoryController({this.repository});

  final isCheckedBox = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  deleteCard(String id){
    return repository.deleteCard(id);
  }
}
