import 'dart:convert';

import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
import 'package:pa_template/utils/models/base_card.dart';
import 'package:pa_template/utils/models/base_gallery_card.dart';

import '../../card_module/card_model/card_detail_model.dart';
import '../../card_module/card_model/card_model.dart';


List<GalleryModel> galleryCardFromJson(String str) => List<GalleryModel>.from(
    json.decode(str).map((x) => GalleryModel.fromJson(x)));

String galleryCardToJson(List<GalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryModel extends BaseGalleryCard {

  GalleryModel(
      {category,
      id,
      isVerify,
      card,
      createdAt,
      ratePoint,
      rateCount,
      starAverage,
      reported,
      isBlocked,
      reportCount})
      : super(category,id, isVerify, card, createdAt, ratePoint, rateCount, starAverage,
            reported, isBlocked, reportCount);

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      category: json["category"],
      id: json["id"],
      isVerify: json["isVerify"],
      card: CardModel.fromJson(json["card"]),
      createdAt: json["createdAt"],
      rateCount: json["rateCount"],
      ratePoint: json["ratePoint"],
      starAverage: json["starAverage"].toDouble(),
      reported: json["reported"],
      isBlocked: json["isBlocked"],
      reportCount: json["reportCount"] == null
          ? null
          : List<bool>.from(json["reportCount"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "category": category,
        "isVerify": isVerify,
        "card": CardModel().toJson(),
        "createdAt": createdAt,
        "rateCount": rateCount,
        "ratePoint": ratePoint,
        "starAverage": starAverage,
        "reported": reported,
        "isBlocked": isBlocked,
        "reportCount": reportCount == null
            ? null
            : List<dynamic>.from(reportCount.map((x) => x)),
      };
}
