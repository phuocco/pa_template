import 'dart:convert';

import 'package:pa_template/models/card_detail_model.dart';

import 'base_card.dart';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel extends BaseCard {
  CardModel(
      {isVerify,
      id,
      card,
      createdAt,
      rateCount,
      ratePoint,
      starAverage,
      reported,
      category,
      isBlocked,
      reportCount})
      : super(isVerify, id, card, createdAt, rateCount, ratePoint, starAverage,
            reported, category, isBlocked, reportCount);

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        isVerify: json["isVerify"],
        id: json["id"],
        card: CardDetailModel.fromJson(json["card"]),
        createdAt: json["createdAt"],
        rateCount: json["rateCount"],
        ratePoint: json["ratePoint"],
        starAverage: json["starAverage"].toDouble(),
        reported: json["reported"],
        category: json["category"],
        isBlocked: json["isBlocked"],
        reportCount: json["reportCount"] ==
            null ? null : List<bool>.from(json["reportCount"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isVerify": isVerify,
        "id": id,
        "card": CardDetailModel().toJson(),
        "createdAt": createdAt,
        "rateCount": rateCount,
        "ratePoint": ratePoint,
        "starAverage": starAverage,
        "reported": reported,
        "category": category,
        "isBlocked": isBlocked,
        "reportCount": List<dynamic>.from(reportCount.map((x) => x)),
      };
}
