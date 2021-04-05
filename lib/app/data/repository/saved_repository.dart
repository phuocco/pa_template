import 'dart:io';

import 'package:pa_template/app/data/provider/saved_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pa_template/models/card_detail_model.dart';
import 'package:pa_template/models/card_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SavedRepository {
  final SavedProvider provider;

  SavedRepository({@required this.provider}) : assert(provider != null);

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

  uploadFile(File file, String container) => provider.uploadFile(file, container);

  uploadCard(CardDetailModel cardModel) => provider.uploadCard(cardModel);
}