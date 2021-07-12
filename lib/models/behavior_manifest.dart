import 'dart:core';


import 'package:mods_guns/models/header.dart';
import 'package:mods_guns/models/module.dart';

class BehaviorManifest {
  num format_version;
  Header header;
  List<Module> modules;
  List<Dependency> dependencies;

  BehaviorManifest(
      this.format_version, this.header, this.modules);

  factory BehaviorManifest.fromJson(Map<String, dynamic> json) =>
      BehaviorManifest(
        json['format_version'] as num,
        json['header'] == null
            ? null
            : Header.fromJson(json['header'] as Map<String, dynamic>),
        (json['modules'] as List)
            ?.map((e) =>
        e == null ? null : Module.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      )..dependencies = (json['dependencies'] as List)
          ?.map((e) =>
      e == null ? null : Dependency.fromJson(e as Map<String, dynamic>))
          ?.toList();

  Map<String, dynamic> toJson() => <String, dynamic>{
    'format_version': this.format_version,
    'header': this.header,
    'modules': this.modules,
    'dependencies': this.dependencies,
  };
}

class Dependency {
  String uuid;
  List<num> version;

  Dependency(this.uuid,this.version);

  factory Dependency.fromJson(Map<String, dynamic> json) =>
      Dependency(
        json['uuid'] as String,
        (json['version'] as List)?.map((e) => e as num)?.toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': this.uuid,
    'version': this.version,
  };
}