
import 'dart:convert';

NewCreatorItem newCreatorItemFromJson(String str) =>
    NewCreatorItem.fromJson(json.decode(str));

String newCreatorItemToJson(NewCreatorItem data) => json.encode(data.toJson());

List<NewCreator> newCreatorFromJson(String str) =>
    new List<NewCreator>.from(json.decode(str).map((x) => NewCreator.fromJson(x)));

List<NewCreatorItem> parseNewCreatorItem(String str) => new List<NewCreatorItem>.from(
    json.decode(str).map((x) => NewCreatorItem.fromJson(x)));

String newCreatorToJson(List<NewCreator> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class NewCreator {
  List<NewCreatorItem> items;
  String addonName;
  String authorName;

  NewCreator({this.items, this.addonName, this.authorName});

  factory NewCreator.fromJson(Map<String, dynamic> json) => new NewCreator(
    items: json["items"] == null
        ? null
        : (json['items'] as List)
        .map((x) => NewCreatorItem.fromJson(x))
        .toList(),
    addonName: json["addonName"] == null ? null : json["addonName"],
    authorName: json["authorName"] == null ? null : json["authorName"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : items,
    "addonName": addonName == null ? null : addonName,
    "authorName": authorName == null ? null : authorName,
  };
}

class NewCreatorItem {

  String itemName;
  String itemIcon;
  String itemSkin;

  NewCreatorItem({this.itemName, this.itemIcon, this.itemSkin});

  factory NewCreatorItem.fromJson(Map<String, dynamic> json) => new NewCreatorItem(
    itemName: json["item_name"] == null ? null : json["item_name"],
    itemIcon: json["item_icon"] == null ? null : json["item_icon"],
    itemSkin: json["item_skin"] == null ? null : json["item_skin"],
  );

  Map<String, dynamic> toJson() => {
    "item_name": itemName == null ? null : itemName,
    "item_icon": itemIcon == null ? null : itemIcon,
    "item_skin": itemSkin == null ? null : itemSkin
  };
}

class NewItemDefault {
  NewCreatorItem item;
  bool isChangeData;
  NewItemDefault({this.item, this.isChangeData = false});
}