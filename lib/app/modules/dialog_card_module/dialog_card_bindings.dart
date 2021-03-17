import 'package:pa_template/app/modules/dialog_card_module/dialog_card_controller.dart';
import 'package:pa_template/app/data/provider/dialog_card_provider.dart';
import 'package:pa_template/app/data/repository/dialog_card_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DialogCardController(repository: DialogCardRepository(provider: DialogCardProvider())));
  }
}