import 'package:mods_guns/app/data/repository/creator_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorController extends GetxController{

  final CreatorRepository repository;

  CreatorController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
