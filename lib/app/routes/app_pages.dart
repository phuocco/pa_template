import '../../app/modules/add_entity_module/add_entity_page.dart';
import '../../app/modules/add_entity_module/add_entity_bindings.dart';
import '../../app/modules/creator_module/creator_page.dart';
import '../../app/modules/creator_module/creator_bindings.dart';
import '../../app/modules/search_module/search_page.dart';
import '../../app/modules/search_module/search_bindings.dart';
import '../../app/modules/favorite_module/favorite_page.dart';
import '../../app/modules/favorite_module/favorite_bindings.dart';
import '../../app/modules/more_apps_module/more_apps_page.dart';
import '../../app/modules/more_apps_module/more_apps_bindings.dart';
import '../../app/modules/question_module/question_page.dart';
import '../../app/modules/question_module/question_bindings.dart';
import '../../app/modules/tutorial_module/tutorial_page.dart';
import '../../app/modules/tutorial_module/tutorial_bindings.dart';
import '../../app/modules/language_module/language_page.dart';
import '../../app/modules/language_module/language_bindings.dart';
import '../../app/modules/detail_module/detail_page.dart';
import '../../app/modules/detail_module/detail_bindings.dart';
import '../../app/modules/test_native_module/test_native_page.dart';
import '../../app/modules/test_native_module/test_native_bindings.dart';


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
      name: Routes.TEST_NATIVE,
      page: () => TestNativePage(),
      binding: TestNativeBinding(),
    ),
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
      name: Routes.TUTORIAL,
      page: () => TutorialPage(),
      binding: TutorialBinding(),
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
      name: Routes.CREATOR,
      page: () => CreatorPage(),
      binding: CreatorBinding(),
    ),
    GetPage(
      name: Routes.ADD_ENTITY,
      page: () => AddEntityPage(),
      binding: AddEntityBinding(),
    ),
  ];
}
