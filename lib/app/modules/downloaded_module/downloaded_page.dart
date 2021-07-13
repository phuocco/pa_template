

import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';

class DownloadedPage extends StatelessWidget{

  DownloadedPage();
  final box = GetStorage();

  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mainController.listDownloadedNew.length == 0) {
        //TODO: UI loading before get data
        return Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('Empty',
                    textStyle: TextStyle(color: kColorAppbar)),
              ],
              repeatForever: true,
            ),
          ),
        );
      } else {
       return context.isPhone
            ? ListView.builder(
            itemCount: mainController.listDownloadedNew.length,
            itemBuilder: (context, index) {
              if (mainController.listDownloadedNew[index] == 'Ads') {
                return mainController.indexStack.value == 3 ? Card(
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
                // var indexDownload =
                // mainController.listDownloaded.indexWhere((element) {
                //   if (mainController.listAddon[index] != 'Ads') {
                //     return element.id == mainController.listAddon[index].itemId;
                //   } else {
                //     return false;
                //   }
                // });
                String pathFile = '';
                // if (indexDownload != -1) {
                //   mainController.listFavorite[index].isDownloaded = true;
                //   mainController.listFavorite[index].pathUrl = mainController.listDownloaded[indexDownload].pathFile;
                // }

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
                  mainController.listFavorite[index].isFavorite = true;
                }
                // return Text(mainController.listDownloadedNew[index].toJson().toString());
                return BuildPhone(
                  controller: mainController,
                  pathFile: mainController.listDownloadedNew[index].pathUrl,
                  index: index,
                  page: 'Downloaded',
                  onFavoriteTap: () {
                    print(mainController.listDownloaded.length);
                    // print(mainController.listDownloadedNew[index].pathUrl);
                    var indexDownloaded = mainController.listDownloaded.indexWhere((element) => element.id == mainController.listDownloadedNew[index].itemId);
                    if(indexDownloaded != -1){

                      var indexHot =
                      mainController.listAddon.indexWhere((element) {
                        if (element != 'Ads') {
                          return element.itemId == mainController.listDownloadedNew[index].itemId;
                        } else {
                          return false;
                        }
                      });
                      if(indexHot != -1){
                        mainController.listAddon[indexHot].pathUrl ='';
                        mainController.listAddon[indexHot].isDownloaded = false;
                      }

                      var indexNew =
                      mainController.listAddonNew.indexWhere((element) {
                        if (element != 'Ads') {
                          return element.itemId == mainController.listDownloadedNew[index].itemId;
                        } else {
                          return false;
                        }
                      });
                      if(indexHot != -1){
                        mainController.listAddonNew[indexNew].pathUrl ='';
                        mainController.listAddonNew[indexNew].isDownloaded = false;
                      }





                      File delete = File(mainController.listDownloadedNew[index].pathUrl);
                      delete.existsSync();
                      mainController.listDownloaded.removeAt(indexDownloaded);
                      mainController.listDownloadedNew.removeAt(index);
                      mainController.listAddon.refresh();
                      mainController.listAddonNew.refresh();
                      mainController.listDownloadedNew.refresh();
                      GetStorage().write("LIST_DOWNLOADEDNEW", mainController.listDownloadedNew);
                      GetStorage().write("LIST_DOWNLOADED", mainController.listDownloaded);
                    }

                  },
                  addonsItem: mainController.listDownloadedNew[index],
                );
              }
            })
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 40 / 33,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: mainController.listDownloadedNew.length,
          itemBuilder: (context, index) {
            if (mainController.listDownloadedNew[index] == 'Ads') {
              return mainController.indexStack.value == 3 ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: NativeAdHomeWidget(
                    adItem:
                    nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                semanticContainer: false,
              ) : SizedBox();
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
              // if (indexDownload != -1) {
              //   mainController.listFavorite[index].isDownloaded = true;
              //   mainController.listFavorite[index].pathUrl = mainController.listDownloaded[indexDownload].pathFile;
              // }

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
                mainController.listFavorite[index].isFavorite = true;
              }
              // return Text(mainController.listDownloadedNew[index].toJson().toString());
              return BuildTablet(
                  controller: mainController,
                  pathFile: mainController.listDownloadedNew[index].pathUrl,
                  index: index,
                  page: 'Downloaded',
                onFavoriteTap: () {
                  print(mainController.listDownloaded.length);
                  // print(mainController.listDownloadedNew[index].pathUrl);
                  var indexDownloaded = mainController.listDownloaded.indexWhere((element) => element.id == mainController.listDownloadedNew[index].itemId);
                  if(indexDownloaded != -1){

                    var indexHot =
                    mainController.listAddon.indexWhere((element) {
                      if (element != 'Ads') {
                        return element.itemId == mainController.listDownloadedNew[index].itemId;
                      } else {
                        return false;
                      }
                    });
                    if(indexHot != -1){
                      mainController.listAddon[indexHot].pathUrl ='';
                      mainController.listAddon[indexHot].isDownloaded = false;
                    }

                    var indexNew =
                    mainController.listAddonNew.indexWhere((element) {
                      if (element != 'Ads') {
                        return element.itemId == mainController.listDownloadedNew[index].itemId;
                      } else {
                        return false;
                      }
                    });
                    if(indexHot != -1){
                      mainController.listAddonNew[indexNew].pathUrl ='';
                      mainController.listAddonNew[indexNew].isDownloaded = false;
                    }


                    File delete = File(mainController.listDownloadedNew[index].pathUrl);
                    delete.existsSync();
                    mainController.listDownloaded.removeAt(indexDownloaded);
                    mainController.listDownloadedNew.removeAt(index);
                    mainController.listAddon.refresh();
                    mainController.listAddonNew.refresh();
                    mainController.listDownloadedNew.refresh();
                    GetStorage().write("LIST_DOWNLOADEDNEW", mainController.listDownloadedNew);
                    GetStorage().write("LIST_DOWNLOADED", mainController.listDownloaded);
                  }
                },
                addonsItem: mainController.listDownloadedNew[index]
              );
            }
          },
        );
      }

    });
  }
}