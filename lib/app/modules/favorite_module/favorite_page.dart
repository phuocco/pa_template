import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_controller.dart';
import 'package:mods_guns/app/modules/main_module/item_phone.dart';
import 'package:mods_guns/app/modules/main_module/item_tablet.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_page.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';
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
                var indexDownload =
                    mainController.listDownloaded.indexWhere((element) {
                  if (mainController.listAddon[index] != 'Ads') {
                    return element.id == mainController.listAddon[index].itemId;
                  } else {
                    return false;
                  }
                });
                String pathFile = '';
                if (indexDownload != -1) {
                  mainController.listFavoriteWithAds[index].isDownloaded = true;
                  mainController.listFavoriteWithAds[index].pathUrl = mainController.listDownloaded[indexDownload].pathFile;
                }

                var indexFavorite =
                    mainController.listFavorite.indexWhere((element) {
                  if (mainController.listAddon[index] != 'Ads') {
                    return element.itemId ==
                        mainController.listAddon[index].itemId;
                  } else {
                    return false;
                  }
                });
                if (indexFavorite != -1) {
                  mainController.listFavoriteWithAds[index].isFavorite = true;
                }
                return ItemPhone(
                  controller: mainController,
                  pathFile: mainController.listFavoriteWithAds[index].pathUrl,
                  index: index,
                  page: 'Favorite',
                  onFavoriteTap: () {
                    mainController.listFavoriteWithAds[index].isFavorite =
                        false;
                    int indexItem =
                        mainController.listAddon.indexWhere((element) {
                      if (element != 'Ads') {
                        return element.itemId ==
                            mainController.listFavoriteWithAds[index].itemId;
                      } else {
                        return false;
                      }
                    });
                    mainController.listAddon[indexItem].isFavorite = false;
                    mainController.savePrefFavoriteItem(
                        mainController.listFavoriteWithAds[index]);
                    mainController.listAddon.refresh();
                    mainController.listAddonNew.refresh();
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
                var indexDownload =
                    mainController.listDownloaded.indexWhere((element) {
                  if (mainController.listAddon[index] != 'Ads') {
                    return element.id == mainController.listAddon[index].itemId;
                  } else {
                    return false;
                  }
                });
                String pathFile = '';
                if (indexDownload != -1) {
                  mainController.listAddon[index].isDownloaded = true;
                  mainController.listFavorite[index].isDownloaded = true;
                  mainController.listFavorite[index].pathUrl = mainController.listDownloaded[indexDownload].pathFile;
                }
                var indexFavorite = mainController.listFavorite.indexWhere(
                    (element) =>
                        element.itemId ==
                        mainController.listAddon[index].itemId);
                if (indexFavorite != -1) {
                  mainController.listFavorite[index].isFavorite = true;
                }
                return ItemTablet(
                    controller: mainController,
                    pathFile: mainController.listFavoriteWithAds[index].pathUrl,
                    index: index,
                    page: 'Favorite',
                    onFavoriteTap: () {
                      mainController.listFavoriteWithAds[index].isFavorite =
                          false;
                      int indexItem =
                          mainController.listAddon.indexWhere((element) {
                        if (element != 'Ads') {
                          return element.itemId ==
                              mainController.listFavoriteWithAds[index].itemId;
                        } else {
                          return false;
                        }
                      });
                      mainController.listAddon[indexItem].isFavorite = false;
                      mainController.savePrefFavoriteItem(
                          mainController.listFavoriteWithAds[index]);
                      mainController.listAddon.refresh();
                      mainController.listAddonNew.refresh();
                    },
                    addonsItem: mainController.listFavoriteWithAds[index]);
              }
            },
          ));
  }
}
