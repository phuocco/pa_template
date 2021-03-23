

import 'package:get/get.dart';
import 'package:pa_template/app/data/provider/dialog_card_provider.dart';
import 'package:pa_template/app/data/provider/gallery_item_provider.dart';
import 'package:pa_template/app/data/provider/gallery_provider.dart';
import 'package:pa_template/app/data/provider/home_provider.dart';
import 'package:pa_template/app/data/provider/main_provider.dart';
import 'package:pa_template/app/data/provider/saved_provider.dart';
import 'package:pa_template/app/data/repository/dialog_card_repository.dart';
import 'package:pa_template/app/data/repository/gallery_item_repository.dart';
import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:pa_template/app/data/repository/main_repository.dart';
import 'package:pa_template/app/data/repository/saved_repository.dart';
import 'package:pa_template/app/modules/dialog_card_module/dialog_card_controller.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_controller.dart';
import 'package:pa_template/app/modules/history_module/history_controller.dart';
import 'package:pa_template/app/data/provider/history_provider.dart';
import 'package:pa_template/app/data/repository/history_repository.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'gallery_module/gallery_controller.dart';
import 'home_module/home_controller.dart';
import 'main_module/main_controller.dart';

class AllBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController(repository: GalleryRepository(provider: GalleryProvider())));
    Get.lazyPut(() => HistoryController(repository: HistoryRepository(provider: HistoryProvider())));
    Get.lazyPut(() => HomeController(repository: HomeRepository(provider: HomeProvider())));
    Get.lazyPut(() => MainController(repository: MainRepository(provider: MainProvider())));
    Get.lazyPut(() => SavedController(repository: SavedRepository(provider: SavedProvider())));
    //Get.lazyPut(() => AdsController());
    Get.lazyPut(() => GalleryItemController(repository: GalleryItemRepository(provider: GalleryItemProvider())));
    Get.lazyPut(() => DialogCardController(repository: DialogCardRepository(provider: DialogCardProvider())));

  }
}