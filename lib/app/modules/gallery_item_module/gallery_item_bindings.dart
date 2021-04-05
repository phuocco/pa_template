import 'package:pa_template/app/modules/gallery_item_module/gallery_item_controller.dart';
import 'package:pa_template/app/data/provider/gallery_item_provider.dart';
import 'package:pa_template/app/data/repository/gallery_item_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryItemController(repository: GalleryItemRepository(provider: GalleryItemProvider())));
  }
}