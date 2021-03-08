import 'dart:convert';

List<BaseCard> baseGalleryCardFromJson(String str) =>
    List<BaseCard>.from(json.decode(str).map((x) => BaseCard.fromJson(x)));

String baseGalleryCardToJson(List<BaseCard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaseCard {
  BaseCard({
    this.arrLink,
    this.atk,
    this.bluePendulum,
    this.cardCategory,
    this.cardDesc,
    this.cardImg,
    this.cardName,
    this.cardPath,
    this.cardTit,
    this.cardType,
    this.colorCardName,
    this.createdAt,
    this.def,
    this.defPendulum,
    this.pendulum,
    this.premium,
    this.rainbow,
    this.rank,
    this.redPendulum,
    this.star,
    this.theme,
    this.themeType,
    this.thumbUrl,
    this.yourName,
  });

  List<dynamic> arrLink;
  String atk;
  String bluePendulum;
  String cardCategory;
  String cardDesc;
  String cardImg;
  String cardName;
  String cardPath;
  String cardTit;
  String cardType;
  int colorCardName;
  int createdAt;
  String def;
  String defPendulum;
  bool pendulum;
  bool premium;
  bool rainbow;
  int rank;
  String redPendulum;
  int star;
  String theme;
  String themeType;
  String thumbUrl;
  String yourName;

  factory BaseCard.fromJson(Map<String, dynamic> json) => BaseCard(
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
