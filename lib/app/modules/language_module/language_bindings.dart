import 'package:pa_template/app/modules/language_module/language_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}