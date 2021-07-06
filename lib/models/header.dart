class Header {
  String description;
  String name;
  String uuid;
  List<num> version;
  List<num> min_engine_version;

  Header(this.description, this.name, this.uuid, this.version,
      this.min_engine_version);

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    json['description'] as String,
    json['name'] as String,
    json['uuid'] as String,
    (json['version'] as List)?.map((e) => e as num)?.toList(),
    (json['min_engine_version'] as List)?.map((e) => e as num)?.toList(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'description': this.description,
    'name': this.name,
    'uuid': this.uuid,
    'version': this.version,
    'min_engine_version': this.min_engine_version,
  };
}