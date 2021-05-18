// To parse this JSON data, do
//
//     final popularHome = popularHomeFromJson(jsonString);

import 'dart:convert';

List<AddonsItem> addonsItemFromJson(String str) => List<AddonsItem>.from(
    json.decode(str).map((x) => AddonsItem.fromJson(x)));

String addonsItemToJson(List<AddonsItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddonsItem {
  AddonsItem({
    this.itemId,
    this.typeId,
    this.categoryId,
    this.itemName,
    this.fileUrl,
    this.imageUrl,
    this.thumbUrl,
    this.authorName,
    this.version,
    this.size,
    this.description,
    this.htmlDescription,
    this.shortDescription,
    this.hotPriority,
    this.downloadCount,
    this.videoCode,
    this.isVerify,
    this.createTime,
    this.price,
    this.isDownloaded,
    this.pathUrl,
    this.isFavorite
  });

  String itemId;
  String typeId;
  String categoryId;
  String itemName;
  String fileUrl;
  String imageUrl;
  String thumbUrl;
  String authorName;
  String version;
  String size;
  String description;
  String htmlDescription;
  String shortDescription;
  String hotPriority;
  String downloadCount;
  String videoCode;
  String isVerify;
  DateTime createTime;
  String price;
  bool isDownloaded;
  String pathUrl;
  bool isFavorite;

  factory AddonsItem.fromJson(Map<String, dynamic> json) => AddonsItem(
    itemId: json["item_id"],
    typeId: json["type_id"],
    categoryId: json["category_id"],
    itemName: json["item_name"],
    fileUrl: json["file_url"],
    imageUrl: json["image_url"],
    thumbUrl: json["thumb_url"],
    authorName: json["author_name"],
    version: json["version"],
    size: json["size"],
    description: json["description"],
    htmlDescription: json["html_description"],
    shortDescription: json["short_description"],
    hotPriority: json["hot_priority"],
    downloadCount: json["download_count"],
    videoCode: json["video_code"],
    isVerify: json["is_verify"],
    createTime: DateTime.parse(json["create_time"]),
    price: json["price"],
    isDownloaded: false,
    pathUrl: null,
    isFavorite: false,

  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "type_id": typeId,
    "category_id": categoryId,
    "item_name": itemName,
    "file_url": fileUrl,
    "image_url": imageUrl,
    "thumb_url": thumbUrl,
    "author_name": authorName,
    "version": version,
    "size": size,
    "description": description,
    "html_description": htmlDescription,
    "short_description": shortDescription,
    "hot_priority": hotPriority,
    "download_count": downloadCount,
    "video_code": videoCode,
    "is_verify": isVerify,
    "create_time": createTime.toIso8601String(),
    "price": price,
    "isDownloaded": isDownloaded,
    "pathUrl": pathUrl,
    "isFavorite": isFavorite,
  };
}
