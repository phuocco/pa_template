

import 'dart:convert';

import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';

List<HistoryCardModel> historyCardFromJson(String str) => List<HistoryCardModel>.from(
    json.decode(str).map((x) => HistoryCardModel.fromJson(x)));

String historyCardToJson(List<HistoryCardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryCardModel {
  CardDetailModel card;
  bool isUploaded = false;
  int id;

  HistoryCardModel({this.card, this.isUploaded, this.id});

  factory HistoryCardModel.fromJson(Map<String, dynamic> json) => HistoryCardModel(

    isUploaded: json["isUploaded"],
    card: CardDetailModel.fromJson(json["card"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "isUploaded": isUploaded,
    "card": card.toJson(),
    "id": id,
  };

}