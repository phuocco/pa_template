import 'dart:convert';

List<MoreApp> getAppFromJson(String str) =>
    List<MoreApp>.from(json.decode(str).map((x) => MoreApp.fromJson(x)));

class MoreApp {
  String icon;
  String name;
  String packageName;
  String banner;
  String description;
  MoreApp(this.icon, this.name, this.packageName, this.banner, this.description);

  MoreApp.fromJson(Map<String, dynamic> json)
      : icon = json['icon']??"",
        name = json['name']??"",
        packageName = json['packageName']??"",
        banner = json['banner']??"",
        description = json['description']??"";

}

class IosAppInfo {
  List<Result> results;

  IosAppInfo({
    this.results,
  });

  factory IosAppInfo.fromJson(Map<String, dynamic> json) => new IosAppInfo(
    results: new List<Result>.from(
        json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int trackId;

  Result({
    this.trackId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    trackId: json["trackId"],
  );

  Map<String, dynamic> toJson() => {
    "trackId": trackId,
  };
}