class Module {
  String description;
  String type;
  String uuid;
  List<num> version;

  Module(this.description, this.type, this.uuid, this.version);

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    json['description'] as String,
    json['type'] as String,
    json['uuid'] as String,
    (json['version'] as List)?.map((e) => e as num)?.toList(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'description': this.description,
    'type': this.type,
    'uuid': this.uuid,
    'version': this.version,
  };
}
