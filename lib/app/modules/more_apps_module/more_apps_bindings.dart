import 'package:pa_template/app/modules/more_apps_module/more_apps_controller.dart';
import 'package:pa_template/app/data/provider/more_apps_provider.dart';
import 'package:pa_template/app/data/repository/more_apps_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MoreAppsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreAppsController(repository: MoreAppsRepository(provider: MoreAppsProvider())));
  }
}