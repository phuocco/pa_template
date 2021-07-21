import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/main_module/item_tablet.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';

import 'item_phone.dart';
import 'main_page.dart';

class MainPageDownload extends StatelessWidget {
  MainPageDownload();

  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listAddon.length == 0) {
        //TODO: UI loading before get data
        return Center(
          child: Text(controller.timeOutText.value == 'timeOut' ? 'Timeout, can’t connect to server' : 'Loading', style: TextStyle(fontSize: 25),),
        );
      }

      return context.isPhone
          ? ListView.builder(
          itemCount: controller.listAddon.length,
          itemBuilder: (context, index) {
            //region phone
            if (controller.listAddon[index] == 'Ads') {
              return controller.indexStack.value == 0 ? Card(
                // key: ValueKey<int>(index),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: NativeAdHomeWidget(
                  adItem: nativeHomeAdControllerNew == null
                      ? null
                      : nativeHomeAdControllerNew.getAdsByIncreaseIndex(),
                ),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                semanticContainer: false,
              ) : SizedBox();
            } else {
              var indexDownload = controller.listDownloaded.indexWhere(
                      (element) =>
                  element.id == controller.listAddon[index].itemId);
              String pathFile = '';
              if (indexDownload != -1) {
                controller.listAddon[index].isDownloaded = true;
                controller.listAddon[index].pathUrl =
                    controller.listDownloaded[indexDownload].pathFile;
                pathFile =
                    controller.listDownloaded[indexDownload].pathFile;
              }
              var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                  element.itemId == controller.listAddon[index].itemId);
              if (indexFavorite != -1) {
                controller.listAddon[index].isFavorite = true;
              }
              return ItemPhone(
                controller: controller,
                pathFile: controller.listAddon[index].pathUrl,
                index: index,
                onFavoriteTap: () {
                  controller.listAddon[index].isFavorite =
                  !controller.listAddon[index].isFavorite;
                  controller
                      .savePrefFavoriteItem(controller.listAddon[index]);
                  controller.listAddon.refresh();
                  controller.listAddonNew.refresh();
                },
                addonsItem: controller.listAddon[index],
              );
            }
          }
        //endregion

      )
          :
      //fixme: tablet
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 40 / 33,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: controller.listAddon.length,
          itemBuilder: (context, index) {
            if (controller.listAddon[index] == 'Ads') {
              return controller.indexStack.value == 0 ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: NativeAdHomeWidget(
                  adItem: nativeHomeAdControllerNew == null
                      ? null
                      : nativeHomeAdControllerNew.getAdsByIncreaseIndex(),
                ),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                semanticContainer: false,
              ) : SizedBox();
            } else {
              var indexDownload = controller.listDownloaded.indexWhere(
                      (element) =>
                  element.id == controller.listAddon[index].itemId);
              String pathFile = '';
              if (indexDownload != -1) {
                controller.listAddon[index].isDownloaded = true;
                controller.listAddon[index].pathUrl =
                    controller.listDownloaded[indexDownload].pathFile;
                pathFile =
                    controller.listDownloaded[indexDownload].pathFile;
              }

              var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                  element.itemId == controller.listAddon[index].itemId);
              if (indexFavorite != -1) {
                controller.listAddon[index].isFavorite = true;
              }
              return ItemTablet(
                controller: controller,
                pathFile: controller.listAddon[index].pathUrl,
                index: index,
                addonsItem: controller.listAddon[index],
                onFavoriteTap: () {
                  controller.listAddon[index].isFavorite =
                  !controller.listAddon[index].isFavorite;
                  controller
                      .savePrefFavoriteItem(controller.listAddon[index]);
                  controller.listAddon.refresh();
                  controller.listAddonNew.refresh();
                },
              );
            }
          });
    });
  }
}