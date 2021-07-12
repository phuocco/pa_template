import 'package:mods_guns/models/header.dart';
import 'package:mods_guns/models/module.dart';

class ResourceManifest {
  num format_version;
  Header header;
  List<Module> modules;

  ResourceManifest(this.format_version, this.header, this.modules);

  factory ResourceManifest.fromJson(Map<String, dynamic> json) =>
      ResourceManifest(
        json['format_version'] as num,
        json['header'] == null
            ? null
            : Header.fromJson(json['header'] as Map<String, dynamic>),
        (json['modules'] as List)
            ?.map((e) =>
        e == null ? null : Module.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'format_version': this.format_version,
    'header': this.header,
    'modules': this.modules,
  };
}