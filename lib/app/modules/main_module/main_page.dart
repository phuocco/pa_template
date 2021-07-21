import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/app/modules/detail_module/detail_page.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_page.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/search_module/search_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/theme/app_text_theme.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'package:mods_guns/models/addons_item.dart';
import 'package:mods_guns/widgets/base_banner.dart';
import 'package:mods_guns/widgets/native_ad_detail_widget.dart';

import 'main_page_create_time.dart';
import 'main_page_download.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainController());

  final AdsController adsController = Get.find();
  final DetailController detailController = Get.find();
  final NativeAdControllerNew nativeAdControllerNew = Get.find();
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.onStart();

    return GetPlatform.isAndroid
        ? MainPageDownload()
        : Container(
            color: Colors.red,
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: controller.indexStack.value,
                        children: [
                          MainPageDownload(),
                          MainPageCreateTime(),
                          SearchPage(),
                          DownloadedPage(),
                        ],
                      ),
                    ),
                  ),
                  BaseBanner(),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 10,
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomButton(
                        controller: controller,
                        onPress: controller.setIndexStack(0),
                        iconPath: kHottestIcon,
                        indexStack: 0,
                        text: 'HOTTEST',
                      ),
                      BottomButton(
                        controller: controller,
                        onPress: controller.setIndexStack(1),
                        iconPath: kNewestIcon,
                        indexStack: 1,
                        text: 'NEWEST',
                      ),
                      BottomButton(
                        controller: controller,
                        onPress: controller.setIndexStack(2),
                        iconPath: kSearchIcon,
                        indexStack: 2,
                        text: 'SEARCH',
                      ),
                      BottomButton(
                        controller: controller,
                        onPress: controller.setIndexStack(3),
                        iconPath: kManageIcon,
                        indexStack: 3,
                        text: 'MANAGE',
                      ),
                      // MaterialButton(
                      //   padding: EdgeInsets.all(5),
                      //   minWidth: 40,
                      //   // onPressed: () =>
                      //   //     controller.selectPageNew2('Main Page Create Time'),
                      //   onPressed: () => controller.setIndexStack(1),
                      //   child: Obx(
                      //     () => Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Image.asset(
                      //           'assets/images/icons/ic_newest.png',
                      //           width: 28,
                      //           height: 28,
                      //           color: controller.indexStack.value == 1
                      //               ? kColorAppbar
                      //               : Colors.grey,
                      //         ),
                      //         Text('NEWEST',
                      //             style: controller.indexStack.value == 1
                      //                 ? selectedTab
                      //                 : unselectedTab),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // MaterialButton(
                      //   padding: EdgeInsets.all(5),
                      //   minWidth: 40,
                      //   // onPressed: () =>
                      //   //     controller.selectPageNew2('Search Page'),
                      //   onPressed: () => controller.setIndexStack(2),
                      //   child: Obx(
                      //     () => Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Image.asset(
                      //           'assets/images/icons/ic_search.png',
                      //           width: 28,
                      //           height: 28,
                      //           color: controller.indexStack.value == 2
                      //               ? kColorAppbar
                      //               : Colors.grey,
                      //         ),
                      //         Text('SEARCH',
                      //             style: controller.indexStack.value == 2
                      //                 ? selectedTab
                      //                 : unselectedTab),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // MaterialButton(
                      //   padding: EdgeInsets.all(5),
                      //   minWidth: 40,
                      //   // onPressed: () =>
                      //   //     controller.selectPageNew2('Downloaded Page'),
                      //   onPressed: () => controller.setIndexStack(3),
                      //   child: Obx(
                      //     () => Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Image.asset(
                      //           'assets/images/icons/ic_manage.png',
                      //           width: 28,
                      //           height: 28,
                      //           color: controller.indexStack.value == 3
                      //               ? kColorAppbar
                      //               : Colors.grey,
                      //         ),
                      //         Text('MANAGE',
                      //             style: controller.indexStack.value == 3
                      //                 ? selectedTab
                      //                 : unselectedTab),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  showDetailDialog({AddonsItem addonsItem, String pathFile}) {
    detailController.textButton.value =
        addonsItem.isDownloaded ? 'install'.tr : 'download'.tr;
    return Get.dialog(
            Dialog(
              insetPadding: EdgeInsets.all(150),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: kColorAppbar,
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            addonsItem.itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          Spacer(),

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
                                  width: (Get.width - 300) * 0.75,
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
                                width: (Get.width - 300) * 0.75,
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
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/icons/heart_black.svg'),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          ),
                        ],
                      ),
                    ),
                    //todo: ad dialog
                    Container(
                      margin: EdgeInsets.all(10),
                      child: NativeAdDetailWidget(
                          adItem: nativeDetailAdControllerNew
                              .getAdsByIncreaseIndex()),
                    ),
                    // Obx(() => Text(detailController.progress.value.toString())),
                    Column(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () async {
                              !addonsItem.isDownloaded
                                  ? DetailPage().downloadInstallAddon(
                                      addonsItem,
                                      isTablet: true,
                                      isDetail: false)
                                  // : detailController.importToMinecraft(addonsItem.pathUrl);
                                  : DetailPage()
                                      .dialogAskInstall(addonsItem.pathUrl);
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
                                      width: detailController
                                              .isDownloading.value
                                          ? detailController.progress.value *
                                              Get.width
                                          : Get.width,
                                      duration: Duration(milliseconds: 50),
                                      curve: Curves.fastOutSlowIn,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      detailController.textButton.value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: detailController
                                                  .isDownloading.value
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
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue.withOpacity(0.01),
                      child: addonsItem.htmlDescription.isBlank ||
                              addonsItem.htmlDescription == ''
                          ? Text(addonsItem.description)
                          : HtmlWidget(addonsItem.htmlDescription),
                    ),
                  ],
                ),
              ),
            ),
            barrierDismissible: true)
        .whenComplete(() {
      nativeDetailAdControllerNew.requestAds();
      nativeHomeAdControllerNew.requestAds();
      controller.listAddon.refresh();
      controller.listAddonNew.refresh();

      if (detailController.cancelToken.isCancelled) {
        detailController.dio.close();
        detailController.cancelToken.cancel();
      }
      detailController.progress.value = 0;
      detailController.isDownloading.value = false;
      detailController.isDownloaded.value = false;
    });
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    @required this.controller,
    @required this.onPress,
    @required this.iconPath,
    @required this.indexStack,
    @required this.text,
  });

  final MainController controller;
  final Function onPress;
  final String iconPath;
  final int indexStack;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(5),
      minWidth: 40,
      onPressed: onPress,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              iconPath,
              width: 28,
              height: 28,
              color:
                  controller.indexStack.value == indexStack ? kColorAppbar : Colors.grey,
            ),
            Text(text,
                style: controller.indexStack.value == indexStack
                    ? selectedTab
                    : unselectedTab),
          ],
        ),
      ),
    );
  }
}
