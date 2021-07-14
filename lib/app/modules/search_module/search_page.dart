import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_page.dart';
import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SearchPage extends StatelessWidget {
  final controller = Get.put(SearchController());
  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.getSearchItems(context, controller.searchText);
    return controller.searchText.toString() == "" ? SizedBox() : Obx(() {
      if (controller.listAddonSearchWithAds.length == 0) {
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
          itemCount: controller.listAddonSearchWithAds.length,
          itemBuilder: (context, index) {
            if (controller.listAddonSearchWithAds[index] == 'Ads') {
              return mainController.indexStack.value == 2 ? Card(
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
              ) : SizedBox();
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
              return BuildPhone(
                controller: mainController,
                pathFile: controller.listAddonSearchWithAds[index].pathUrl,
                index: index,
                page: 'Search',
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
            return mainController.indexStack.value == 2 ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: NativeAdHomeWidget(
                  adItem:
                  nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              semanticContainer: false,
            ) :  SizedBox();
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
                pathFile: controller.listAddonSearchWithAds[index].pathUrl,
                index: index,
                page: 'Search',
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
      );
    });
  }
}
