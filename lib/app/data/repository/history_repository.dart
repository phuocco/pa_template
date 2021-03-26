import 'package:pa_template/app/data/provider/history_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryRepository {
  final HistoryProvider provider;

  HistoryRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }
  deleteCard(String id) =>  provider.deleteCard(id);
}