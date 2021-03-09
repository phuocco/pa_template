
import 'dart:convert';

import 'package:get/get.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/utils/services/network_helper.dart';

import '../../../constants/const_url.dart';
import '../card_model/card_model.dart';

class CardController extends GetxController {

  var card =  CardModel().obs;
  var test = 'test'.obs;

  @override
  void onInit() {
    fetchCard();
    super.onInit();
  }

  void fetchCard() async {
    NetworkHelper networkHelper = NetworkHelper(url: getCardUrl);

    networkHelper.getCard().then((value) {

      card.value = value;

    });

  }
}