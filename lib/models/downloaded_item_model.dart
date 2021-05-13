

import 'dart:convert';


List<DownloadedItemModel> downloadedItemFromJson(String str) => List<DownloadedItemModel>.from(
    json.decode(str).map((x) => DownloadedItemModel.fromJson(x)));

String historyCardToJson(List<DownloadedItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DownloadedItemModel {
  String id;
  String pathFile;

  DownloadedItemModel({this.id, this.pathFile});

  factory DownloadedItemModel.fromJson(Map<String, dynamic> json) => DownloadedItemModel(

    id: json["id"],
    pathFile: json["pathFile"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "pathFile": pathFile,
  };

}