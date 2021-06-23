import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/app/data/provider/creator_provider.dart';
import 'package:mods_guns/app/data/repository/creator_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatorController(repository: CreatorRepository(provider: CreatorProvider())));
  }
}