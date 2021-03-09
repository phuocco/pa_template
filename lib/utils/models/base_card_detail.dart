class BaseCardDetail {
  BaseCardDetail(
      {this.cardCategory,
      this.cardDesc,
      this.cardImg,
      this.cardName,
      this.cardPath,
      this.createdAt,
      this.premium,
      this.thumbUrl});

  String cardCategory;
  String cardDesc;
  String cardImg;
  String cardName;
  String cardPath;
  int createdAt;
  bool premium;
  String thumbUrl;
}
