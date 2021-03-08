// To parse this JSON data, do
//
//     final baseGalleryCard = baseGalleryCardFromJson(jsonString);

import 'dart:convert';

import 'package:pa_template/utils/models/base_card.dart';

List<BaseGalleryCard> baseGalleryCardFromJson(String str) =>
    List<BaseGalleryCard>.from(
        json.decode(str).map((x) => BaseGalleryCard.fromJson(x)));

String baseGalleryCardToJson(List<BaseGalleryCard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaseGalleryCard {
  BaseGalleryCard({
    this.isVerify,
    this.id,
    this.card,
    this.createdAt,
    this.rateCount,
    this.ratePoint,
    this.starAverage,
    this.reported,
    this.category,
    this.isBlocked,
    this.reportCount,
  });

  bool isVerify;
  String id;
  BaseCard card;
  int createdAt;
  int rateCount;
  int ratePoint;
  double starAverage;
  bool reported;
  String category;
  bool isBlocked;
  List<bool> reportCount;

  factory BaseGalleryCard.fromJson(Map<String, dynamic> json) =>
      BaseGalleryCard(
        isVerify: json["isVerify"],
        id: json["id"],
        card: BaseCard.fromJson(json["card"]),
        createdAt: json["createdAt"],
        rateCount: json["rateCount"],
        ratePoint: json["ratePoint"],
        starAverage: json["starAverage"].toDouble(),
        reported: json["reported"],
        category: json["category"],
        isBlocked: json["isBlocked"],
        reportCount: json["reportCount"] == null
            ? null
            : List<bool>.from(json["reportCount"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isVerify": isVerify,
        "id": id,
        "card": card.toJson(),
        "createdAt": createdAt,
        "rateCount": rateCount,
        "ratePoint": ratePoint,
        "starAverage": starAverage,
        "reported": reported,
        "category": category,
        "isBlocked": isBlocked,
        "reportCount": reportCount == null
            ? null
            : List<dynamic>.from(reportCount.map((x) => x)),
      };
}
