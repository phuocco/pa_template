// To parse this JSON data, do
//
//     final baseGalleryCard = baseGalleryCardFromJson(jsonString);

import 'dart:convert';

import 'package:pa_template/utils/models/base_card.dart';

class BaseGalleryCard {
  bool isVerify;
  String id;
  BaseCard card;
  int createdAt;
  int rateCount;
  int ratePoint;
  double starAverage;
  bool reported;
  bool isBlocked;
  List<bool> reportCount;

  BaseGalleryCard(
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
