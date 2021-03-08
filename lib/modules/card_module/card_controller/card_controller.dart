
import 'package:get/get.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/modules/card_module/card_model/card_model.dart';
import 'package:pa_template/utils/services/network_helper.dart';

class CardController extends GetxController {
  var card = CardModel().obs;

  @override
  void onInit() {
    fetchGalleryList();
    super.onInit();
  }

  void fetchGalleryList() async {
    NetworkHelper networkHelper = NetworkHelper(url: galleryUrl);

    networkHelper.getGallery().then((value) {
      card = value[0];
      print(card);
    });
  }
}