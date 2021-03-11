import 'package:pa_template/app/data/repository/saved_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SavedController extends GetxController{

  final SavedRepository repository;

  SavedController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
