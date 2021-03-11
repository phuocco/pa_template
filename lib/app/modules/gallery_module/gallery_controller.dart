import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryController extends GetxController{

  final GalleryRepository repository;

  GalleryController({this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
