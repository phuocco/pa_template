import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/main_module/main_page.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class FavoritePage extends StatelessWidget {
  final FavoriteController controller = Get.find();
  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => context.isPhone
        ? ListView.builder(
            itemCount: mainController.listFavoriteWithAds.length,
            itemBuilder: (context, index) {
              if (mainController.listFavoriteWithAds[index] == 'Ads') {
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
                        element.id == mainController.listAddon[index].itemId);
                String pathFile = '';
                if (indexDownload != -1) {
                  // mainController.listAddon[index].isDownloaded = true;
                  pathFile =
                      mainController.listDownloaded[indexDownload].pathFile;
                }

                var indexFavorite = mainController.listFavorite.indexWhere(
                    (element) =>
                        element.itemId ==
                        mainController.listAddon[index].itemId);
                if (indexFavorite != -1) {
                  mainController.listAddon[index].isFavorite = true;
                }
                return BuildPhone(
                  controller: mainController,
                  pathFile: mainController.listFavoriteWithAds[index].pathUrl,
                  index: index,
                  page: 'Favorite',
                  onFavoriteTap: () {
                    mainController.listFavoriteWithAds[index].isFavorite =
                        false;
                    int indexItem =   mainController.listAddon.indexWhere((element) {
                      if(element != 'Ads'){
                        return element.itemId == mainController.listFavoriteWithAds[index].itemId;
                      } else {
                        return false;
                      }
                    });
                    mainController.listAddon[indexItem].isFavorite = false;
                    mainController.savePrefFavoriteItem(
                        mainController.listFavoriteWithAds[index]);
                    mainController.listAddon.refresh();

                  },
                  addonsItem: mainController.listFavoriteWithAds[index],
                );
              }
            })
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 40 / 33,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: mainController.listFavoriteWithAds.length,
            itemBuilder: (context, index) {
              if (mainController.listFavoriteWithAds[index] == 'Ads') {
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
                    element.id == mainController.listAddon[index].itemId);
                String pathFile = '';
                if (indexDownload != -1) {
                  mainController.listAddon[index].isDownloaded = true;
                  pathFile =
                      mainController.listDownloaded[indexDownload].pathFile;
                }

                var indexFavorite = mainController.listFavorite.indexWhere(
                        (element) =>
                    element.itemId ==
                        mainController.listAddon[index].itemId);
                if (indexFavorite != -1) {
                  mainController.listAddon[index].isFavorite = true;
                }
                return BuildTablet(
                    controller: mainController,
                    pathFile: mainController.listFavoriteWithAds[index].pathUrl,
                    index: index,
                    page: 'Favorite',
                    onFavoriteTap: () {
                      mainController.listFavoriteWithAds[index].isFavorite =
                      false;
                      int indexItem =   mainController.listAddon.indexWhere((element) {
                        if(element != 'Ads'){
                          return element.itemId == mainController.listFavoriteWithAds[index].itemId;
                        } else {
                          return false;
                        }
                      });
                      mainController.listAddon[indexItem].isFavorite = false;
                      mainController.savePrefFavoriteItem(
                          mainController.listFavoriteWithAds[index]);
                      mainController.listAddon.refresh();
                    },
                    addonsItem: mainController.listFavoriteWithAds[index]);
              }
            },
          ));
  }
}
