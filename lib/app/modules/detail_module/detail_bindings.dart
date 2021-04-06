import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/data/provider/detail_provider.dart';
import 'package:pa_template/app/data/repository/detail_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController(repository: DetailRepository(provider: DetailProvider())));
  }
}