
import 'package:get/get.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
import 'package:pa_template/utils/services/network_helper.dart';

import '../../../constants/const_url.dart';
import '../../gallery_module/model/gallery_model.dart';
import '../card_model/card_detail_model.dart';
import '../card_model/card_detail_model.dart';
import '../card_model/card_model.dart';

class CardController extends GetxController {

  final card =  CardModel().obs;
  @override
  void onInit() {
    fetchCard();
    super.onInit();
  }

  void fetchCard() async {
    NetworkHelper networkHelper = NetworkHelper(url: getCardUrl);

    networkHelper.getCard().then((value) {
      print(value);
    });

  }
}