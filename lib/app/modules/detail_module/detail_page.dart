import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/app/modules/home_module/home_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/models/addons_item.dart';
import 'package:mods_guns/widgets/native_ad_detail_widget.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailPage extends StatelessWidget {
  final DetailController controller = Get.find();
  final AdsController adsController = Get.find();
  final MainController mainController = Get.find();
  final SearchController searchController = Get.find();
  final AddonsItem addonsItem;
  final String pathFile;
  DetailPage({this.addonsItem, this.pathFile});

  @override
  Widget build(BuildContext context) {
    controller.textButton.value =
        addonsItem.isDownloaded ? 'install'.tr : 'download'.tr;
    print(!controller.isDownloaded.value);
    print(pathFile);
    print(addonsItem.pathUrl);
    controller.addonsItem.value = addonsItem;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorAppbar,
        brightness: Brightness.dark,
        title: Text(addonsItem.itemName),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: addonsItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: kBottomDetailColor,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width * 0.64,
                          height: 60,
                          child: Text(
                            addonsItem.itemName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          )),
                      SizedBox(
                        width: Get.width * 0.64,
                        child: Text(
                          addonsItem.authorName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (controller.addonsItem.value.isFavorite) {
                              controller.addonsItem.value.isFavorite = false;
                              addonsItem.isFavorite = false;
                            } else {
                              controller.addonsItem.value.isFavorite = true;
                              addonsItem.isFavorite = true;
                            }
                            mainController.savePrefFavoriteItem(addonsItem);
                            mainController.listAddon.refresh();
                            mainController.listAddonNew.refresh();
                            controller.addonsItem.refresh();
                            print(controller.addonsItem.value.isFavorite);
                          },
                          child: SvgPicture.asset(
                            controller.addonsItem.value.isFavorite
                                ? kHeartFull
                                : kHeartAround,
                            color: kColorLikeIcon,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            addonsItem.downloadCount,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset('assets/images/icons/download.svg'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kNativeAdBackground
              ),
              child: NativeAdDetailWidget(
                  adItem: nativeDetailAdControllerNew.getAdsByIncreaseIndex(index: Random().nextInt(2))),
            ),
            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () async {
                      !addonsItem.isDownloaded
                          ? downloadInstallAddon(addonsItem, isDetail: true)
                          // : controller.importToMinecraft(mainController
                          //     .listDownloaded[indexDownload].pathFile);
                          : dialogAskInstall(addonsItem.pathUrl);
                      // : print(addonsItem.pathUrl);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: Get.width,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: addonsItem.isDownloaded
                                ? kColorInstallButtonBackground
                                : kColorDownloadButtonBackground,
                            width: 1,
                          )),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: AnimatedContainer(
                              color: addonsItem.isDownloaded
                                  ? kColorInstallButtonBackground
                                  : kColorDownloadButtonBackground,
                              width: controller.isDownloading.value
                                  ? controller.progress.value * Get.width
                                  : Get.width,
                              duration: Duration(milliseconds: 50),
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                          Center(
                            child: Text(
                              controller.textButton.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.isDownloading.value
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Supports 1.16.200+',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            // Image.asset('assets/images/ads.png'),
            // Container(
            //   margin: EdgeInsets.all(10),
            //   child: BaseNative(
            //       adWidget: AdWidget(
            //         ad: adsController.myNativeAd,
            //       ),
            //       completer: adsController.nativeAdCompleter),
            // ),

            Container(
              margin: EdgeInsets.all(10),
              color: Colors.blue.withOpacity(0.01),
              // child: Text(addonsItem.description),
              child: addonsItem.htmlDescription.isNullOrBlank
                  ? Text(addonsItem.description)
                  : HtmlWidget(addonsItem.htmlDescription),
            ),
          ],
        ),
      ),
    );
  }

  downloadInstallAddon(AddonsItem item,
      {bool isDetail, int index, bool isTablet, String page}) async {
    if(mainController.isConnecting.value == false){
      Fluttertoast.showToast(
          msg: "You are not connected to the internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if (!controller.isDownloading.value || controller.cancelToken.isCancelled) {
      adsController.showIntersAds();
      // ProgressDialog pr;
      if (!isDetail && !isTablet) {
        // pr = new ProgressDialog(context: Get.context);
        // pr.show(max: 100, msg: "misc_download_message".tr, barrierDismissible: true);
        Get.dialog(WillPopScope(
          onWillPop: () async {
          if(controller.isDownloaded.value == false){
            return false;
          } else {
            return true;
          }
          },
          child: AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(),
                Text('misc_download_message'.tr),
                // Obx(() => Text(controller.progress.value.toString()),),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                controller.dio.close();
                controller.cancelToken.cancel();
                controller.progress.value = 0;
                controller.isDownloading.value = false;
                controller.isDownloaded.value = false;
                Get.back();
              }, child: Text('CANCEL', style: TextStyle(color: Colors.black),),
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(
                //         Colors.grey
                //     ),
                //     foregroundColor: MaterialStateProperty.all<Color>(
                //         Colors.white
                //     )
                // ),
              ),
            ],
          ),
        ),
            barrierDismissible: false);
      }
      controller.installAddon(item.fileUrl).then((value) {
        if (controller.isDownloaded.value) {
          print('downloaded');
          mainController.savePrefDownloadedItem(item,
              item.itemId, controller.finalPath.value);
          if (isDetail) {
            controller.isDownloaded.value = true;
            addonsItem.isDownloaded = true;
            addonsItem.pathUrl = controller.finalPath.value;
            controller.textButton.value = 'install'.tr;
            mainController.listAddon.refresh();
            mainController.listAddonNew.refresh();
          } else if (isTablet) {
            item.isDownloaded = true;
            controller.isDownloaded.value = true;
            controller.textButton.value = 'install'.tr;
            item.pathUrl = controller.finalPath.value;
            mainController.listAddon.refresh();
            mainController.listAddonNew.refresh();
            print("tablet " + controller.finalPath.value);
          } else if (page == 'Search') {
            print(index);
            // pr.close();
            Get.back();
            searchController.listAddonSearchWithAds[index].pathUrl =
                controller.finalPath.value;
            searchController.listAddonSearchWithAds[index].isDownloaded = true;
            searchController.listAddonSearchWithAds.refresh();
            int indexFav = mainController.listFavoriteWithAds.indexWhere((element) {
              if(element != 'Ads'){
                return element.itemId == searchController.listAddonSearchWithAds[index].itemId;
              } else {
                return false;
              }
            });
            if(indexFav != -1){
              mainController.listFavoriteWithAds[index].pathUrl = controller.finalPath.value;
              mainController.listFavoriteWithAds[index].isDownloaded = true;
              mainController.listFavoriteWithAds.refresh();
            }

          } else if (page == 'Favorite') {
            print(index);
            // pr.close();
            Get.back();
            mainController.listFavoriteWithAds[index].pathUrl =
                controller.finalPath.value;
            mainController.listFavoriteWithAds[index].isDownloaded = true;
            mainController.listFavoriteWithAds.refresh();
            print('a');
          } else {
            print(index);
            // pr.close();
            Get.back();
            mainController.updateAddonItemInList(
                index, controller.finalPath.value);
            mainController.listAddon.refresh();
            mainController.listAddonNew.refresh();
          }
          //Dialog ask only on android
          // GetPlatform.isAndroid
          //     ? dialogAskImport()
          //     : controller.importToMinecraft(controller.finalPath.value);
          //both android ios
          dialogAskImport();
        }
      });
    } else {
      print("token " + controller.cancelToken.isCancelled.toString());
      if (!controller.cancelToken.isCancelled) {
        controller.dio.close();
        controller.cancelToken.cancel();
        controller.progress.value = 0;
        controller.isDownloading.value = false;
        controller.isDownloaded.value = false;
      }
    }
  }

  dialogAskImport() {
    if (controller.isDownloaded.value) {
      // Get.back();
      Get.dialog(
          AlertDialog(
            title: Text('file_downloaded'.tr),
            content: Text('ask_install_now'.tr),
            actions: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'.toUpperCase())),
              TextButton(
                  onPressed: () {
                    print(controller.finalPath.value);
                    controller.importToMinecraft(controller.finalPath.value);
                    Get.back();
                  },
                  child: Text('Install addon'.toUpperCase())),
            ],
          ),
          barrierDismissible: false);
    }
  }

  dialogAskInstall(String path) {
    adsController.showIntersAds();
    Get.dialog(
        AlertDialog(
          title: Text('file_installed'.tr),
          content: Text('ask_open'.tr),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel'.toUpperCase())),
            TextButton(
                onPressed: () {
                  print(path);
                  controller.importToMinecraft(path);
                  Get.back();
                },
                child: Text('Open'.toUpperCase())),
          ],
        ),
        barrierDismissible: false);
  }
}
