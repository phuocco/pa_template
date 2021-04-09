import 'package:pa_template/app/data/repository/question_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class QuestionController extends GetxController{

  final QuestionRepository repository;

  QuestionController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
