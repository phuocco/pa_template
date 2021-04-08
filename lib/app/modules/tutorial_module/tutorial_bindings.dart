import 'package:pa_template/app/modules/tutorial_module/tutorial_controller.dart';
import 'package:pa_template/app/data/provider/tutorial_provider.dart';
import 'package:pa_template/app/data/repository/tutorial_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TutorialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TutorialController(repository: TutorialRepository(provider: TutorialProvider())));
  }
}