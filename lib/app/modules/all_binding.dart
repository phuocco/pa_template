

import 'package:get/get.dart';
import 'package:pa_template/app/data/provider/home_provider.dart';
import 'package:pa_template/app/data/provider/main_provider.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:pa_template/app/modules/language_module/language_controller.dart';
import 'package:pa_template/app/modules/tutorial_module/tutorial_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'home_module/home_controller.dart';
import 'main_module/main_controller.dart';

class AllBinding extends Bindings {

  @override
  void dependencies() {
    // Get.lazyPut(() => GalleryController(repository: GalleryRepository(provider: GalleryProvider())));
    // Get.lazyPut(() => HistoryController(repository: HistoryRepository(provider: HistoryProvider())));
    Get.lazyPut(() => HomeController(repository: HomeRepository(provider: HomeProvider())));
    Get.lazyPut(() => MainController(repository: MainRepository(provider: MainProvider())));
    // Get.lazyPut(() => SavedController(repository: SavedRepository(provider: SavedProvider())));
    Get.lazyPut(() => AdsController());
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => TutorialController());
    // Get.lazyPut(() => GalleryItemController(repository: GalleryItemRepository(provider: GalleryItemProvider())));
    // Get.lazyPut(() => DialogCardController(repository: DialogCardRepository(provider: DialogCardProvider())));

  }
}