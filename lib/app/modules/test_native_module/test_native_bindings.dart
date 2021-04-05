import 'package:pa_template/app/modules/test_native_module/test_native_controller.dart';
import 'package:pa_template/app/data/provider/test_native_provider.dart';
import 'package:pa_template/app/data/repository/test_native_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TestNativeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestNativeController(repository: TestNativeRepository(provider: TestNativeProvider())));
  }
}