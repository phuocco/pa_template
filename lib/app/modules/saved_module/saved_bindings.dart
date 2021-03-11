import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/app/data/provider/saved_provider.dart';
import 'package:pa_template/app/data/repository/saved_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SavedBinding implements Bindings {
  @override
  void dependencies() {
    print("put");
    Get.lazyPut(() => SavedController(repository: SavedRepository(provider: SavedProvider())));
  }
}