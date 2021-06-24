import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/data/provider/add_entity_provider.dart';
import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEntityController(repository: AddEntityRepository(provider: AddEntityProvider())));
  }
}