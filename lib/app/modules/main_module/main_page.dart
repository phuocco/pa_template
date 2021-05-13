import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/modules/detail_module/detail_page.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/constants/const_drawer.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/controllers/native_ad_controller_new.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/widgets/native_ad_detail_widget.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainController());
  final AdsController adsController = Get.find();
  final DetailController detailController = Get.find();
  final NativeAdControllerNew nativeAdControllerNew = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => context.isPhone
          ? ListView.builder (
              itemCount: controller.listAddon.length,
              itemBuilder: (context, index) {

                if(controller.listAddon[index] == 'Ads'){
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: NativeAdHomeWidget(
                        adItem: nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    semanticContainer: false,
                  );
                } else {
                  var indexDownload = controller.listDownloaded.indexWhere((element) => element.id == controller.listAddon[index].itemId);
                  // var indexDownload =  controller.listDownloaded.where((value) => controller.listAddon[index].itemId == value.id);
                  print('index: '+ indexDownload.toString());
                  return GestureDetector(
                    onTap: () => Get.to(() => DetailPage(addonsItem: controller.listAddon[index],indexDownload: indexDownload,)),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.listAddon[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 15,
                                  right: 15,
                                  child: SvgPicture.asset(
                                    'assets/images/icons/heart_black.svg',
                                    color: kColorLikeIcon,
                                  )),
                            ]),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: kColorBottomItem,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
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
                                            controller.listAddon[index].itemName,
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
                                          controller.listAddon[index].authorName,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          indexDownload == -1 ? DetailPage().downloadInstallAddon(controller.listAddon[index]):
                                          detailController.importToMinecraft(controller.listDownloaded[indexDownload].pathFile);
                                        },
                                        child: Text(
                                          indexDownload == -1 ? "DOWNLOAD": "OPEN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kColorDownloadButtonForeground),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kColorDownloadButtonBackground),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller
                                                .listAddon[index].downloadCount,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/icons/download.svg'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      semanticContainer: false,
                    ),
                  );
                }


              })
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
                if(controller.listAddon[index] == 'Ads'){
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: NativeAdHomeWidget(
                        adItem: nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    semanticContainer: false,
                  );
                }

                return GestureDetector(
                  onTap:() => showDetailDialog(controller.listAddon[index]),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: CachedNetworkImage(
                                  imageUrl: controller.listAddon[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 15,
                                right: 15,
                                child: SvgPicture.asset(
                                  'assets/images/icons/heart_black.svg',
                                  color: kColorLikeIcon,
                                )),
                          ]),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: kColorBottomItem,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        width: Get.width * 0.30,
                                        height: 60,
                                        child: Text(
                                          controller.listAddon[index].itemName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.30,
                                      child: Text(
                                        controller.listAddon[index].authorName,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      // onPressed: () async => DetailPage().downloadInstallAddon(controller.listAddon[index].fileUrl),
                                      child: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kColorDownloadButtonForeground),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kColorDownloadButtonBackground),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller
                                              .listAddon[index].downloadCount,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/icons/download.svg'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    semanticContainer: false,
                  ),
                );
              }),
    );
  }

  showDetailDialog(AddonsItem addonsItem){
    return Get.dialog(Dialog(
      insetPadding: EdgeInsets.all(150),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: kColorAppbar,
              width: double.infinity,
              height:50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () => Get.back(),icon: Icon(Icons.arrow_back_ios ,color: Colors.white,),),
                  Text(addonsItem.itemName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),),
                  IconButton(onPressed: () => Get.back(),icon: Icon(Icons.share_outlined ,color: Colors.white,),),
                ],
              ),
            ),
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
                          width: (Get.width - 300) * 0.80,
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
                        width: (Get.width - 300) * 0.80,
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
                  Padding(
                    padding: const EdgeInsets.only(right:5.0),
                    child: Column(
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
                  ),
                ],
              ),
            ),
            //todo: ad dialog
            NativeAdDetailWidget(
                adItem: nativeDetailAdControllerNew.getAdsByIncreaseIndex()),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: Get.width,
                  height: 45,
                  child: TextButton(

                    // onPressed: () async => DetailPage().downloadInstallAddon(addonsItem.fileUrl),
                    child: Text(
                      'DOWNLOAD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          kColorDownloadButtonForeground),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          kColorDownloadButtonBackground),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10, bottom: 5),
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
            Container(
              margin: EdgeInsets.all(10),
              height: 400,
              color: Colors.blue.withOpacity(0.5),
            ),
          ],
        ),
      ),
    ), barrierDismissible: true).whenComplete(()
    {
      nativeDetailAdControllerNew.requestAds();
      nativeHomeAdControllerNew.requestAds();
    });
  }
  // downloadInstallAddon(String link) async {
  //   detailController.installAddon(link).then((value) {
  //     return GetPlatform.isAndroid
  //         ? dialogAskImport()
  //         : detailController
  //             .importToMinecraft(detailController.finalPath.value);
  //   });
  // }

  // dialogAskImport() {
  //   if (detailController.isDownloaded.value) {
  //     Get.back();
  //     Get.dialog(
  //         AlertDialog(
  //           title: Text('File downloaded'),
  //           content: Text('Do you want to install now?'),
  //           actions: [
  //             TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
  //             TextButton(
  //                 onPressed: () => detailController
  //                     .importToMinecraft(detailController.finalPath.value),
  //                 child: Text('Install skin')),
  //           ],
  //         ),
  //         barrierDismissible: false);
  //   }
  // }
}
