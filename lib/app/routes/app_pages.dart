import 'package:mods_guns/app/modules/downloaded_module/downloaded_bindings.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_page.dart';

import '../../app/modules/search_module/search_page.dart';
import '../../app/modules/search_module/search_bindings.dart';
import '../../app/modules/favorite_module/favorite_page.dart';
import '../../app/modules/favorite_module/favorite_bindings.dart';
import '../../app/modules/more_apps_module/more_apps_page.dart';
import '../../app/modules/more_apps_module/more_apps_bindings.dart';
import '../../app/modules/question_module/question_page.dart';
import '../../app/modules/question_module/question_bindings.dart';
import '../../app/modules/language_module/language_page.dart';
import '../../app/modules/language_module/language_bindings.dart';
import '../../app/modules/detail_module/detail_page.dart';
import '../../app/modules/detail_module/detail_bindings.dart';



import '../../app/modules/main_module/main_page.dart';
import '../../app/modules/main_module/main_bindings.dart';
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
    // GetPage(
    //   name: Routes.SAVED,
    //   page: () => SavedPage(),
    //   binding: SavedBinding(),
    // ),
    // GetPage(
    //   name: Routes.GALLERY,
    //   page: () => GalleryPage(),
    //   binding: GalleryBinding(),
    // ),
    // GetPage(
    //   name: Routes.HISTORY,
    //   page: () => HistoryPage(),
    //   binding: HistoryBinding(),
    // ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    // GetPage(
    //   name: Routes.GALLERYITEM,
    //   page: () => GalleryItemPage(),
    //   binding: GalleryItemBinding(),
    // ),
    // GetPage(
    //   name: Routes.DIALOGCARD,
    //   page: () => DialogCardPage(),
    //   binding: DialogCardBinding(),
    // ),

    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: Routes.LANGUAGE,
      page: () => LanguagePage(),
      binding: LanguageBinding(),
    ),

    GetPage(
      name: Routes.QUESTION,
      page: () => QuestionPage(),
      binding: QuestionBinding(),
    ),
    GetPage(
      name: Routes.MORE_APPS,
      page: () => MoreAppsPage(),
      binding: MoreAppsBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.DOWNLOADED,
      page: () => DownloadedPage(),
      binding: DownloadedBinding(),
    ),
  ];
}
