import 'package:pa_template/app/data/repository/gallery_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryController extends GetxController{

  final GalleryRepository repository;

  GalleryController({this.repository});

  final _listCard = <GalleryModel>[].obs;
  get listCard => _listCard;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  getGallery() {
    repository.getGallery().then((data){
      _listCard.assignAll(data);
    });
  }
}
