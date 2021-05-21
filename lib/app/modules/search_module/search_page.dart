import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/app/modules/search_module/search_controller.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchPage extends StatelessWidget {
  final controller = Get.put(SearchController());
  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.getSearchItems(context, controller.searchText);
    return Obx(() => context.isPhone
        ? ListView.builder(
            itemCount: controller.listAddonSearchWithAds.length,
            itemBuilder: (context, index) {
              if (controller.listAddonSearchWithAds[index] == 'Ads') {
                return Card(
                  // key: ValueKey<int>(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: NativeAdHomeWidget(
                      adItem:
                          nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  semanticContainer: false,
                );
              } else {
                var indexDownload = mainController.listDownloaded.indexWhere(
                    (element) =>
                        element.id == controller.listAddonSearch[index].itemId);
                String pathFile = '';
                if (indexDownload != -1) {
                  controller.listAddonSearch[index].isDownloaded = true;
                  controller.listAddonSearch[index].pathUrl =
                      mainController.listDownloaded[indexDownload].pathFile;
                  pathFile =
                      mainController.listDownloaded[indexDownload].pathFile;
                }

                var indexFavorite = mainController.listFavorite.indexWhere(
                    (element) =>
                        element.itemId ==
                        controller.listAddonSearch[index].itemId);
                if (indexFavorite != -1) {
                  controller.listAddonSearch[index].isFavorite = true;
                }
                return BuildPhone(
                  controller: mainController,
                  pathFile: pathFile,
                  index: index,
                  onFavoriteTap: () {
                    controller.listAddonSearchWithAds[index].isFavorite =
                        !controller.listAddonSearchWithAds[index].isFavorite;
                    mainController.savePrefFavoriteItem(
                        controller.listAddonSearchWithAds[index]);
                    controller.listAddonSearchWithAds.refresh();
                  },
                  addonsItem: controller.listAddonSearchWithAds[index],
                );
              }
            })
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 40 / 33,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: controller.listAddonSearchWithAds.length,
            itemBuilder: (context, index) {
              if (controller.listAddonSearchWithAds[index] == 'Ads') {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: NativeAdHomeWidget(
                      adItem:
                          nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  semanticContainer: false,
                );
              } else {
                var indexDownload = mainController.listDownloaded.indexWhere(
                    (element) =>
                        element.id == controller.listAddonSearchWithAds[index].itemId);
                String pathFile = '';
                if (indexDownload != -1) {
                  controller.listAddonSearchWithAds[index].isDownloaded = true;
                  controller.listAddonSearchWithAds[index].pathUrl =
                      mainController.listDownloaded[indexDownload].pathFile;
                  pathFile =
                      mainController.listDownloaded[indexDownload].pathFile;
                }

                var indexFavorite = mainController.listFavorite.indexWhere(
                    (element) =>
                        element.itemId ==
                        controller.listAddonSearchWithAds[index].itemId);
                if (indexFavorite != -1) {
                  controller.listAddonSearchWithAds[index].isFavorite = true;
                }
                return BuildTablet(
                    controller: mainController,
                    pathFile: pathFile,
                    index: index,
                    onFavoriteTap: () {
                      controller.listAddonSearchWithAds[index].isFavorite =
                          !controller.listAddonSearchWithAds[index].isFavorite;
                      mainController.savePrefFavoriteItem(
                          controller.listAddonSearchWithAds[index]);
                      controller.listAddonSearchWithAds.refresh();
                    },
                    addonsItem: controller.listAddonSearchWithAds[index]);
              }
            },
          ));
  }
}
