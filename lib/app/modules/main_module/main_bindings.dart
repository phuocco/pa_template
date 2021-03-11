import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/data/provider/main_provider.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(repository: MainRepository(provider: MainProvider())));
  }
}