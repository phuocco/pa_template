import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/app/modules/detail_module/detail_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/models/addons_item.dart';

import 'main_controller.dart';

class ItemTablet extends StatelessWidget {
  ItemTablet(
      {Key key,
        @required this.controller,
        @required this.pathFile,
        @required this.index,
        @required this.onFavoriteTap,
        @required this.addonsItem,
        this.page})
      : super(key: key);
  final DetailController detailController = Get.find();
  final MainController controller;
  final String pathFile;
  final int index;
  final Function onFavoriteTap;
  final AddonsItem addonsItem;
  final String page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.countInterAd++;
        if (GetStorage().hasData('TIME_OPEN')) {
          if (controller.countInterAd == GetStorage().read('TIME_OPEN')) {
            controller.countInterAd = 0;
            Get.find<AdsController>().showIntersAds();
          }
        } else if (controller.countInterAd == 3) {
          controller.countInterAd = 0;
          Get.find<AdsController>().showIntersAds();
        }
        // if (GetPlatform.isAndroid) {
        Get.to(() => DetailPage(
          addonsItem: addonsItem,
          pathFile: pathFile,
        )).whenComplete(() {
          print('dispose detail');
          nativeDetailAdControllerNew.requestAds();
          nativeHomeAdControllerNew.requestAds();

          if (detailController.cancelToken.isCancelled) {
            detailController.dio.close();
            detailController.cancelToken.cancel();
          }
          detailController.progress.value = 0;
          detailController.isDownloading.value = false;
          // DetailController().isDownloaded.value = false;

          MainController().listAddon.refresh();
          MainController().listAddonNew.refresh();
          detailController.isDownloaded.value = false;
          nativeDetailAdControllerNew.listAds.forEach((element) {
            print("detail " + element.hashCode.toString());
          });
          nativeHomeAdControllerNew.listAds.forEach((element) {
            print("home " + element.hashCode.toString());
          });
        });
        // } else {
        //   MainPage().showDetailDialog(
        //     addonsItem: addonsItem,
        //     pathFile: pathFile,
        //   );
        // }
      },
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
                      imageUrl: addonsItem.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: SvgPicture.asset(
                        page == 'Downloaded'
                            ? kDeleteIcon
                            : addonsItem.isFavorite
                            ? kHeartFull
                            : kHeartAround,
                        color: kColorLikeIcon,
                        height: 24,
                        width: 24,
                      ),
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
                            width: Get.width * 0.25,
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
                          width: Get.width * 0.25,
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
                        Container(
                          width: 110,
                          child: TextButton(
                            onPressed: () async {
                              addonsItem.pathUrl.isNullOrBlank
                                  ? DetailPage().downloadInstallAddon(
                                  addonsItem,
                                  isDetail: false,
                                  isTablet: false,
                                  page: page,
                                  index: index)
                                  : DetailPage()
                                  .dialogAskInstall(addonsItem.pathUrl);
                            },
                            child: Text(
                              !addonsItem.isDownloaded
                                  ? 'download'.tr
                                  : 'install'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  kColorDownloadButtonForeground),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  addonsItem.isDownloaded
                                      ? kColorInstallButtonBackground
                                      : kColorDownloadButtonBackground),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
  }
}