import 'package:get/get.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';
import 'package:pa_template/utils/services/network_helper.dart';

class GalleryController extends GetxController {
  var galleryList = List<GalleryModel>().obs;

  @override
  void onInit() {
    fetchGalleryList();
    super.onInit();
  }

  void fetchGalleryList() async {
    NetworkHelper networkHelper = NetworkHelper(url: galleryUrl);

    networkHelper.getGallery().then((value) {
      galleryList.addAll(value);
    });
  }
}
