class ItemTexture {
  String resource_pack_name;
  String texture_name;
  Map<String,dynamic> texture_data;
  ItemTexture({
    this.resource_pack_name,
    this.texture_name,
    this.texture_data
  });

  factory ItemTexture.fromJson(Map<String, dynamic> json) => ItemTexture(
    resource_pack_name: json['resource_pack_name'] as String,
    texture_name: json['texture_name'] as String,
    texture_data: json['texture_data'] as Map<String, dynamic>,
  );
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('resource_pack_name', this.resource_pack_name);
    writeNotNull('texture_name', this.texture_name);
    writeNotNull('texture_data', this.texture_data);
    return val;
  }
}