import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/data/provider/search_provider.dart';
import 'package:mods_guns/app/data/repository/search_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(repository: SearchRepository(provider: SearchProvider())));
  }
}