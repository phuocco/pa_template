import '../../app/modules/dialog_card_module/dialog_card_page.dart';
import '../../app/modules/dialog_card_module/dialog_card_bindings.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_bindings.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_page.dart';

import '../../app/modules/gallery_item_module/gallery_item_page.dart';
import '../../app/modules/gallery_item_module/gallery_item_bindings.dart';
import '../../app/modules/main_module/main_page.dart';
import '../../app/modules/main_module/main_bindings.dart';
import '../../app/modules/history_module/history_page.dart';
import '../../app/modules/history_module/history_bindings.dart';
import '../../app/modules/gallery_module/gallery_page.dart';
import '../../app/modules/gallery_module/gallery_bindings.dart';
import '../../app/modules/saved_module/saved_page.dart';
import '../../app/modules/saved_module/saved_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import '../../app/modules/home_module/home_bindings.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SAVED,
      page: () => SavedPage(),
      binding: SavedBinding(),
    ),
    GetPage(
      name: Routes.GALLERY,
      page: () => GalleryPage(),
      binding: GalleryBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => HistoryPage(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.GALLERYITEM,
      page: () => GalleryItemPage(),
      binding: GalleryItemBinding(),
    ),
    GetPage(
      name: Routes.DIALOGCARD,
      page: () => DialogCardPage(),
      binding: DialogCardBinding(),
    ),
  ];
}
