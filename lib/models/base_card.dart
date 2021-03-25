import 'dart:convert';


import 'base_card_detail.dart';


class BaseCard {
  BaseCard(
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
      this.reportCount
);

  bool isVerify;
  String id;
  BaseCardDetail card;
  int createdAt;
  int rateCount;
  int ratePoint;
  double starAverage;
  bool reported;
  String category;
  bool isBlocked;
  List<bool> reportCount;

}
