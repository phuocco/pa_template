import 'package:pa_template/app/modules/gallery_module/gallery_controller.dart';
import 'package:pa_template/app/data/provider/gallery_provider.dart';
import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController(repository: GalleryRepository(provider: GalleryProvider())));
  }
}