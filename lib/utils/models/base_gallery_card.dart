// To parse this JSON data, do
//
//     final baseGalleryCard = baseGalleryCardFromJson(jsonString);

import 'dart:convert';

import 'package:pa_template/utils/models/base_card.dart';
import 'package:pa_template/utils/models/base_card_detail.dart';

class BaseGalleryCard {
  String category;
  bool isVerify;
  String id;
  BaseCardDetail card;
  int createdAt;
  int rateCount;
  int ratePoint;
  double starAverage;
  bool reported;
  bool isBlocked;
  List<bool> reportCount;

  BaseGalleryCard(
      this.category,
      this.id,
      this.isVerify,
      this.card,
      this.createdAt,
      this.ratePoint,
      this.rateCount,
      this.starAverage,
      this.reported,
      this.isBlocked,
      this.reportCount);
}
