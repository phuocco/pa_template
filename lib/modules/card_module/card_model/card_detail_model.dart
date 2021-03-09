import 'dart:convert';

import 'package:pa_template/utils/models/base_card.dart';
import 'package:pa_template/utils/models/base_card_detail.dart';

List<CardDetailModel> cardFromJson(String str) =>
    List<CardDetailModel>.from(json.decode(str).map((x) => CardDetailModel.fromJson(x)));

String cardToJson(List<CardDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardDetailModel extends BaseCardDetail {
  CardDetailModel(
      {
    arrLink,
    atk,
    bluePendulum,
    cardCategory,
    cardDesc,
    cardImg,
    cardName,
    cardPath,
    cardTit,
    cardType,
    colorCardName,
    createdAt,
    def,
    defPendulum,
    pendulum,
    premium,
    rainbow,
    rank,
    redPendulum,
    star,
    theme,
    themeType,
    thumbUrl,
    yourName
  }) : super (
            arrLink,
            atk,
            bluePendulum,
            cardCategory,
            cardDesc,
            cardImg,
            cardName,
            cardPath,
            cardTit,
            cardType,
            colorCardName,
            createdAt,
            def,
            defPendulum,
            pendulum,
            premium,
            rainbow,
            rank,
            redPendulum,
            star,
            theme,
            themeType,
            thumbUrl,
            yourName);

  factory CardDetailModel.fromJson(Map<String, dynamic> json) => CardDetailModel(
        arrLink: List<dynamic>.from(json["arrLink"].map((x) => x)),
        atk: json["atk"],
        bluePendulum: json["blue_pendulum"],
        cardCategory: json["card_category"],
        cardDesc: json["card_desc"],
        cardImg: json["card_img"],
        cardName: json["card_name"],
        cardPath: json["card_path"],
        cardTit: json["card_tit"],
        cardType: json["card_type"],
        colorCardName: json["colorCardName"],
        createdAt: json["createdAt"],
        def: json["def"],
        defPendulum: json["def_pendulum"],
        pendulum: json["pendulum"],
        premium: json["premium"],
        rainbow: json["rainbow"],
        rank: json["rank"],
        redPendulum: json["red_pendulum"],
        star: json["star"],
        theme: json["theme"],
        themeType: json["theme_type"],
        thumbUrl: json["thumb_url"],
        yourName: json["your_name"],
      );

  Map<String, dynamic> toJson() => {
        "arrLink": List<dynamic>.from(arrLink.map((x) => x)),
        "atk": atk,
        "blue_pendulum": bluePendulum,
        "card_category": cardCategory,
        "card_desc": cardDesc,
        "card_img": cardImg,
        "card_name": cardName,
        "card_path": cardPath,
        "card_tit": cardTit,
        "card_type": cardType,
        "colorCardName": colorCardName,
        "createdAt": createdAt,
        "def": def,
        "def_pendulum": defPendulum,
        "pendulum": pendulum,
        "premium": premium,
        "rainbow": rainbow,
        "rank": rank,
        "red_pendulum": redPendulum,
        "star": star,
        "theme": theme,
        "theme_type": themeType,
        "thumb_url": thumbUrl,
        "your_name": yourName,
      };
}
