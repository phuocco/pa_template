import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/main_module/item_phone.dart';
import 'package:mods_guns/app/modules/main_module/item_tablet.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';

import 'main_controller.dart';
import 'main_page.dart';

class MainPageCreateTime extends StatelessWidget {
  MainPageCreateTime();

  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listAddonNew.length == 0) {
        //TODO: UI loading before get data
        return Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('Loading',
                    textStyle: TextStyle(color: kColorAppbar)),
                FadeAnimatedText('Loading data',
                    textStyle: TextStyle(color: kColorAppbar)),
                FadeAnimatedText('Loading data ...',
                    textStyle: TextStyle(color: kColorAppbar)),
              ],
              repeatForever: true,
            ),
          ),
        );
      }
      return context.isPhone
          ? ListView.builder(
          itemCount: controller.listAddonNew.length,
          itemBuilder: (context, index) {
            //region phone
            if (controller.listAddonNew[index] == 'Ads') {
              return controller.indexStack.value == 1 ? Card(
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
                  element.id == controller.listAddonNew[index].itemId);
              String pathFile = '';
              if (indexDownload != -1) {
                controller.listAddonNew[index].isDownloaded = true;
                controller.listAddonNew[index].pathUrl =
                    controller.listDownloaded[indexDownload].pathFile;
                pathFile =
                    controller.listDownloaded[indexDownload].pathFile;
              }
              var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                  element.itemId ==
                      controller.listAddonNew[index].itemId);
              if (indexFavorite != -1) {
                controller.listAddonNew[index].isFavorite = true;
              }
              var indexNew = controller.listAddon
                  .indexOf(controller.listAddonNew[index]);
              return ItemPhone(
                controller: controller,
                pathFile: controller.listAddonNew[index].pathUrl,
                index: indexNew,
                onFavoriteTap: () {
                  controller.listAddonNew[index].isFavorite =
                  !controller.listAddonNew[index].isFavorite;
                  controller
                      .savePrefFavoriteItem(controller.listAddonNew[index]);
                  controller.listAddonNew.refresh();
                },
                addonsItem: controller.listAddonNew[index],
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
          itemCount: controller.listAddonNew.length,
          itemBuilder: (context, index) {
            if (controller.listAddonNew[index] == 'Ads') {
              return controller.indexStack.value == 1 ? Card(
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
              ) :  SizedBox();
            } else {
              var indexDownload = controller.listDownloaded.indexWhere(
                      (element) =>
                  element.id == controller.listAddonNew[index].itemId);
              String pathFile = '';
              if (indexDownload != -1) {
                controller.listAddonNew[index].isDownloaded = true;
                controller.listAddonNew[index].pathUrl =
                    controller.listDownloaded[indexDownload].pathFile;
                pathFile =
                    controller.listDownloaded[indexDownload].pathFile;
              }

              var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                  element.itemId ==
                      controller.listAddonNew[index].itemId);
              if (indexFavorite != -1) {
                controller.listAddon[index].isFavorite = true;
              }
              var indexNew = controller.listAddon
                  .indexOf(controller.listAddonNew[index]);

              return ItemTablet(
                controller: controller,
                pathFile: controller.listAddonNew[index].pathUrl,
                index: indexNew,
                addonsItem: controller.listAddonNew[index],
                onFavoriteTap: () {
                  controller.listAddonNew[index].isFavorite =
                  !controller.listAddonNew[index].isFavorite;
                  controller
                      .savePrefFavoriteItem(controller.listAddonNew[index]);
                  controller.listAddonNew.refresh();
                },
              );
            }
          });
    });
  }
}