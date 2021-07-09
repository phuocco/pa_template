
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_controller.dart';


class DownloadedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DownloadedController());
  }
}