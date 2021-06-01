import 'package:mods_guns/app/modules/question_module/question_controller.dart';
import 'package:mods_guns/app/data/provider/question_provider.dart';
import 'package:mods_guns/app/data/repository/question_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class QuestionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionController(repository: QuestionRepository(provider: QuestionProvider())));
  }
}