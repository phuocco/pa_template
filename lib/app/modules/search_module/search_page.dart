import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/app/modules/search_module/search_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchPage extends StatelessWidget {
  final controller = Get.put(SearchController());
  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.getSearchItems(context, controller.searchText);
    return  Obx(() => ListView.builder(itemCount:controller.listAddon.length ,itemBuilder: (context, index){
      var indexDownload = mainController.listDownloaded.indexWhere(
              (element) =>
          element.id == controller.listAddon[index].itemId);
      String pathFile = '';
      if (indexDownload != -1) {
        controller.listAddon[index].isDownloaded = true;
        controller.listAddon[index].pathUrl = mainController.listDownloaded[indexDownload].pathFile;
        pathFile =
            mainController.listDownloaded[indexDownload].pathFile;
      }

      var indexFavorite = mainController.listFavorite.indexWhere(
              (element) =>
          element.itemId == controller.listAddon[index].itemId);
      if (indexFavorite != -1) {
        controller.listAddon[index].isFavorite = true;
      }
      return BuildPhone(
        controller: mainController,
        pathFile: pathFile,
        index: index,
        isFavoritePage: () {
          controller.listAddon[index].isFavorite =
          !controller.listAddon[index].isFavorite;
          mainController
              .savePrefFavoriteItem(controller.listAddon[index]);
          controller.listAddon.refresh();
        },
        addonsItem: controller.listAddon[index],
      );
    }));
  }
}
