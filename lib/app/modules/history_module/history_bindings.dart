import 'package:pa_template/app/modules/history_module/history_controller.dart';
import 'package:pa_template/app/data/provider/history_provider.dart';
import 'package:pa_template/app/data/repository/history_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController(repository: HistoryRepository(provider: HistoryProvider())));
  }
}