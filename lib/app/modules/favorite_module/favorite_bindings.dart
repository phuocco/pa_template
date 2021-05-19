import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/app/data/provider/favorite_provider.dart';
import 'package:pa_template/app/data/repository/favorite_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(repository: FavoriteRepository(provider: FavoriteProvider())));
  }
}