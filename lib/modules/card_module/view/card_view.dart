import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/card_module/card_controller/card_controller.dart';

import '../../gallery_module/controller/gallery_controller.dart';
import '../../gallery_module/controller/gallery_controller.dart';
import '../card_controller/card_controller.dart';
import '../card_controller/card_controller.dart';
import '../card_controller/card_controller.dart';
import '../card_controller/card_controller.dart';
import '../card_controller/card_controller.dart';

class CardView extends StatelessWidget {
  final controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GetX<CardController>(
            init: CardController(),
            builder: (value) {
                if(value.card.value.id == null){
                  return Text('data null');
                }
                return Text(value.card.value.id);
              },
          )
        ),
      ),
    );
  }
}
