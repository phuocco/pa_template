import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/widgets/native_ad_detail_widget.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailPage extends StatelessWidget {
  final controller = Get.put(DetailController());
  final AdsController adsController = Get.find();
  final MainController mainController = Get.find();
  final AddonsItem addonsItem;
  final int indexDownload;
  DetailPage({this.addonsItem, this.indexDownload});

  @override
  Widget build(BuildContext context) {
    controller.textButton.value = addonsItem.isDownloaded ? 'install'.tr : 'download'.tr;
    print(!controller.isDownloaded.value);
    print(indexDownload.toString());
    print(addonsItem.pathUrl);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorAppbar,
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
                      SvgPicture.asset('assets/images/icons/heart_black.svg'),
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
            NativeAdDetailWidget(
                adItem: nativeDetailAdControllerNew.getAdsByIncreaseIndex()),
            Column(
              children: [
                // Obx(() => Text(controller.progress.value.toString())),
                // Obx(() => Text("downloading: " +
                //     controller.isDownloading.value.toString())),
                // Obx(() => Text(
                //     "downloaded: " + controller.isDownloaded.value.toString())),
                Obx(
                  () => GestureDetector(
                    onTap: () async {
                      !addonsItem.isDownloaded
                          ? downloadInstallAddon(addonsItem, isDetail: true)
                          // : controller.importToMinecraft(mainController
                          //     .listDownloaded[indexDownload].pathFile);
                      : dialogAskInstall(mainController
                              .listDownloaded[indexDownload].pathFile);
                      // : print(addonsItem.pathUrl);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: Get.width,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: addonsItem.isDownloaded ?kColorInstallButtonBackground :kColorDownloadButtonBackground,
                            width: 1,
                          )),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: AnimatedContainer(
                              color: addonsItem.isDownloaded ?kColorInstallButtonBackground :kColorDownloadButtonBackground,
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
              height: 400,
              color: Colors.blue.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  downloadInstallAddon(AddonsItem item,{bool isDetail, int index, bool isTablet}) async {

    if (!controller.isDownloading.value || controller.cancelToken.isCancelled) {
      ProgressDialog pr;
     if(!isDetail && !isTablet){
       pr = new ProgressDialog(context: Get.context);
       pr.show(max: 100, msg: "Downloading", barrierDismissible: false);
     }
      controller.installAddon(item.fileUrl).then((value) {
        if(controller.isDownloaded.value){
          print('downloaded');
          mainController.savePrefDownloadedItem(
              item.itemId, controller.finalPath.value);
          if(isDetail){
            controller.isDownloaded.value = true;
            addonsItem.isDownloaded = true;
            addonsItem.pathUrl = controller.finalPath.value;
            controller.textButton.value = 'install'.tr;
          } else if(isTablet){
            item.isDownloaded = true;
            controller.isDownloaded.value = true;
            controller.textButton.value = 'install'.tr;
            item.pathUrl = controller.finalPath.value;
            print("tablet "+ controller.finalPath.value);
          }
          else {
            print(index);
            pr.close();
            mainController.listAddon.refresh();
            mainController.updateAddonItemInList(index, controller.finalPath.value);
            // mainController.listAddon[index].isDownloaded = true;
            // mainController.listAddon[index].pathUrl = controller.finalPath.value;
          }
          GetPlatform.isAndroid
              ? dialogAskImport()
              : controller.importToMinecraft(controller.finalPath.value);
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
            title: Text('File downloaded'),
            content: Text('Do you want to install now?'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
              TextButton(
                  onPressed: () =>
                      controller.importToMinecraft(controller.finalPath.value),
                  child: Text('Install addon')),
            ],
          ),
          barrierDismissible: false);
    }
  }
  dialogAskInstall(String path){
    Get.dialog(
        AlertDialog(
          title: Text('File installed'),
          content: Text('Do you want to open game now?'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  controller.importToMinecraft(path);
                  Get.back();
                }
                    ,
                child: Text('Open')),
          ],
        ),
        barrierDismissible: false);
  }
}
