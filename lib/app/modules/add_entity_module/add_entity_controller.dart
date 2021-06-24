import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityController extends GetxController{

  final AddEntityRepository repository;

  AddEntityController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;


}
