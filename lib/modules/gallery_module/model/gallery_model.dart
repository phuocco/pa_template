import 'dart:convert';

import 'package:pa_template/utils/models/base_card.dart';
import 'package:pa_template/utils/models/base_gallery_card.dart';

List<GalleryModel> galleryCardFromJson(String str) => List<GalleryModel>.from(json.decode(str).map((x) => GalleryModel.fromJson(x)));

String galleryCardToJson(List<GalleryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryModel {
  GalleryModel({
    this.id,
    this.createdAt,
    this.name,
  });

  String id;
  DateTime createdAt;
  String name;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "name": name,
  };
}


// List<GalleryModel> galleryCardFromJson(String str) =>
//     List<GalleryModel>.from(
//         json.decode(str).map((x) => GalleryModel.fromJson(x)));
//
// String galleryCardToJson(List<GalleryModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class GalleryModel extends BaseGalleryCard {
//   GalleryModel(
//       );
//
//   factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
//
//   );
//
//   Map<String, dynamic> toJson() => {
//
//   };
// }
