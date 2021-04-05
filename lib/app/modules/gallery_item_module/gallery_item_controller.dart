import 'package:pa_template/app/data/repository/gallery_item_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryItemController extends GetxController{

  final GalleryItemRepository repository;

  GalleryItemController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
