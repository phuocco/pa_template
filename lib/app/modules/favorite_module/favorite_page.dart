import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
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
                return Card(
                  child: Column(
                    children: [
                      Text(mainController.listFavoriteWithAds[index].itemId),
                      Text("name " + mainController.listFavoriteWithAds[index].itemName),
                      Text("favorite " +
                          mainController.listFavoriteWithAds[index].isFavorite
                              .toString()),
                      Text("downloaded " +
                          mainController.listFavoriteWithAds[index].isDownloaded
                              .toString()),
                      TextButton(
                        onPressed: () {
                          mainController.listFavoriteWithAds[index].isFavorite = false;
                          int inn = mainController.listAddon.indexOf(mainController.listFavoriteWithAds[index]);
                          mainController.listAddon[inn].isFavorite = false;
                          mainController.savePrefFavoriteItem(
                              mainController.listFavoriteWithAds[index]);
                          mainController.listAddon.refresh();
                        },
                        child: Text('favorite'),
                      ),
                      TextButton(
                        onPressed: () {
                         //print(mainController.listFavoriteWithAds[index].itemId);

                        //print(ind);
                        },
                        child: Text('print'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }
            })
        : Text('tablet'));
  }
}
