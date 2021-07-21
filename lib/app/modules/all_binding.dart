

import 'package:get/get.dart';
import 'package:mods_guns/app/data/provider/add_entity_provider.dart';
import 'package:mods_guns/app/data/provider/creator_provider.dart';
import 'package:mods_guns/app/data/provider/home_provider.dart';
import 'package:mods_guns/app/data/provider/main_provider.dart';
import 'package:mods_guns/app/data/provider/search_provider.dart';
import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:mods_guns/app/data/repository/creator_repository.dart';
import 'package:mods_guns/app/data/repository/home_repository.dart';
import 'package:mods_guns/app/data/repository/main_repository.dart';
import 'package:mods_guns/app/data/repository/search_repository.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_page.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_controller.dart';
import 'package:mods_guns/app/modules/language_module/language_controller.dart';
import 'package:mods_guns/app/modules/more_apps_module/more_apps_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/modules/tutorial_module/tutorial_controller.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'add_entity_module/add_entity_controller.dart';
import 'creator_module/creator_controller.dart';
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
    Get.lazyPut(() => NativeAdControllerNew());
    Get.lazyPut(() => DetailController());
    Get.lazyPut(() => MoreAppsController());
    Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => DownloadedPage());

    Get.lazyPut(() => SearchController(repository: SearchRepository(provider: SearchProvider())));
    Get.lazyPut(() => CreatorController(repository: CreatorRepository(provider: CreatorProvider())));
    Get.lazyPut(() => AddEntityController(repository: AddEntityRepository(provider: AddEntityProvider())));


    // Get.lazyPut(() => GalleryItemController(repository: GalleryItemRepository(provider: GalleryItemProvider())));
    // Get.lazyPut(() => DialogCardController(repository: DialogCardRepository(provider: DialogCardProvider())));

  }
}