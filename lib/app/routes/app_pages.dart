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
  ];
}
