import 'package:pa_template/app/data/repository/test_native_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TestNativeController extends GetxController{

  final TestNativeRepository repository;

  TestNativeController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
