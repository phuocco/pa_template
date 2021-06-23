import 'dart:convert';

CreatorItem projectItemsFromJson(String str) =>
    CreatorItem.fromJson(json.decode(str));

String projectItemsToJson(CreatorItem data) => json.encode(data.toJson());

List<Creator> addonsFromJson(String str) =>
    new List<Creator>.from(json.decode(str).map((x) => Creator.fromJson(x)));

List<CreatorItem> parseProjectItems(String str) => new List<CreatorItem>.from(
    json.decode(str).map((x) => CreatorItem.fromJson(x)));

class Creator {
  List<CreatorItem> items;
  String addonName;
  String authorName;
  String description;
  String mImageUrl;
  String addonUrl;
  String downloadUrl;
  String unique;

  Creator(this.unique,
      {this.items,
        this.addonName,
        this.authorName,
        this.description,
        this.addonUrl,
        this.downloadUrl,
        this.mImageUrl});

  factory Creator.fromJson(Map<String, dynamic> json) => new Creator(
    json["unique"] == null ? null : json["unique"],
    items: json["items"] == null
        ? null
        : (json['items'] as List)
        .map((x) => CreatorItem.fromJson(x))
        .toList(),
    addonName: json["addonName"] == null ? null : json["addonName"],
    authorName: json["authorName"] == null ? null : json["authorName"],
    description: json["description"] == null ? null : json["description"],
    mImageUrl: json["mImageUrl"] == null ? null : json["mImageUrl"],
    addonUrl: json["addonUrl"] == null ? null : json["addonUrl"],
    downloadUrl: json["downloadUrl"] == null ? null : json["downloadUrl"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : items,
    "addonName": addonName == null ? null : addonName,
    "authorName": authorName == null ? null : authorName,
    "description": description == null ? null : description,
    "mImageUrl": mImageUrl == null ? null : mImageUrl,
    "addonUrl": addonUrl == null ? null : addonUrl,
    "downloadUrl": downloadUrl == null ? null : downloadUrl,
    "unique": unique == null ? null : unique
  };
}

class CreatorItem {
  String itemName;
  String itemIcon;
  String itemTexture;
  dynamic itemSkinsDir;
  String itemIconsDir;
  String itemEntityDir;
  String itemSkin;
  String itemDesc;
  var jsonObject;
  List<List> craftMap;

  List<dynamic> itemEntityTexture = [];
  List<dynamic> effects;
  dynamic entities;
  dynamic data;
  dynamic dataModel;
  dynamic mobLoot;
  dynamic mobEquipment;
  dynamic mobTrade;
  dynamic multipleSkins;

  List<dynamic> listSkin;
  bool premium;
  bool isNewMob;
  String baseID;
  CreatorItem(
      {this.itemName,
        this.itemIcon,
        this.itemTexture,
        this.itemSkinsDir,
        this.itemIconsDir,
        this.itemEntityDir,
        this.itemSkin,
        this.entities,
        this.listSkin,
        this.itemEntityTexture,
        this.effects,
        this.jsonObject,
        this.data,
        this.dataModel,
        this.mobLoot,
        this.mobEquipment,
        this.mobTrade,
        this.multipleSkins,
        this.premium,
        this.isNewMob,
        this.baseID,
        this.itemDesc,
        this.craftMap});

  factory CreatorItem.fromJson(Map<String, dynamic> json) => new CreatorItem(
      itemName: json["item_name"] == null ? null : json["item_name"],
      itemIcon: json["item_icon"] == null ? null : json["item_icon"],
      itemTexture: json["item_texture"] == null ? null : json["item_texture"],
      itemSkinsDir:
      json["item_skins_dir"] == null ? null : json["item_skins_dir"],
      itemIconsDir:
      json["item_icons_dir"] == null ? null : json["item_icons_dir"],
      itemEntityDir:
      json["item_entity_dir"] == null ? null : json["item_entity_dir"],
      itemSkin: json["item_skin"] == null ? null : json["item_skin"],
      itemDesc: json["item_desc"] == null ? null : json["item_desc"],
      entities: json["entities"] == null ? null : json["entities"],
      itemEntityTexture: json["itemEntityTexture"] == null
          ? null
          : json["itemEntityTexture"],
      effects: json["effects"] == null ? null : json["effects"],
      jsonObject: json["json_object"],
      data: json["data"] == null ? null : json["data"],
      dataModel: json["dataModel"] == null ? null : json["dataModel"],
      mobLoot: json["mobLoot"] == null ? null : json["mobLoot"],
      mobEquipment: json["mobEquipment"] == null ? null : json["mobEquipment"],
      mobTrade: json["mobTrade"] == null ? null : json["mobTrade"],
      multipleSkins:
      json["multipleSkins"] == null ? null : json["multipleSkins"],
      premium: json["premium"] == null ? null : json["premium"],
      isNewMob: json["isNewMob"] == null ? null : json["isNewMob"],
      baseID: json["baseID"] == null ? null : json["baseID"],
      // craftMap: json["craftMap"] == null ? null : json["craftMap"]
      craftMap: json["craftMap"] == null
          ? null
          : (json['craftMap'] as List).map((x) => List.from(x)).toList());

  Map<String, dynamic> toJson() => {
  "item_name": itemName == null ? null : itemName,
  "item_icon": itemIcon == null ? null : itemIcon,
  "item_texture": itemTexture == null ? null : itemTexture,
  "item_skins_dir": itemSkinsDir == null ? null : itemSkinsDir,
  "item_icons_dir": itemIconsDir == null ? null : itemIconsDir,
  "item_entity_dir": itemEntityDir == null ? null : itemEntityDir,
  "item_skin": itemSkin == null ? null : itemSkin,
  "entities": entities == null ? null : entities,
  "itemEntityTexture":
  itemEntityTexture == null ? [] : itemEntityTexture,
  "item_desc": itemDesc == null ? [] : itemDesc,
  "effects": effects == null ? null : effects,
  "json_object": jsonObject == null ? null : jsonObject,
  "data": data == null ? null : data,
  "dataModel": dataModel == null ? null : dataModel,
  "mobLoot": mobLoot == null ? null : mobLoot,
  "mobEquipment": mobEquipment == null ? null : mobEquipment,
  "mobTrade": mobTrade == null ? null : mobTrade,
  "multipleSkins": multipleSkins == null ? null : multipleSkins,
  "premium": premium == null ? null : premium,
  "isNewMob": isNewMob == null ? null : isNewMob,
  "baseID": baseID == null ? null : baseID,
  "craftMap": craftMap == null ? null : craftMap,
};
}

class ItemDefault{
  CreatorItem item;
  bool isChangeData;
  ItemDefault({this.item,this.isChangeData = false});
}
