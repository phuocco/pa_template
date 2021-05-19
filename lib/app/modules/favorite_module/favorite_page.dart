import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class FavoritePage extends StatelessWidget {
  final FavoriteController controller = Get.find();
  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Text(mainController.listAddon.length.toString())),
        Obx(() => Text(mainController.listFavorite.length.toString())),
      ],
    );
  }
}
