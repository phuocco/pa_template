import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/modules/detail_module/detail_page.dart';
import 'package:pa_template/app/modules/favorite_module/favorite_controller.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/app/utils/strings.dart';
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
  // final detailController = Get.put(DetailController());
  final NativeAdControllerNew nativeAdControllerNew = Get.find();
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.onStart();
    return Obx(
      () => context.isPhone
          ? ListView.builder(
              itemCount: controller.listAddon.length,
              itemBuilder: (context, index) {
                if (controller.listAddon[index] == 'Ads') {
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
                  var indexDownload = controller.listDownloaded.indexWhere(
                      (element) =>
                          element.id == controller.listAddon[index].itemId);
                  String pathFile = '';
                  if (indexDownload != -1) {
                    controller.listAddon[index].isDownloaded = true;
                    pathFile =
                        controller.listDownloaded[indexDownload].pathFile;
                  }
                  var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                          element.itemId == controller.listAddon[index].itemId);
                  if (indexFavorite != -1) {
                    controller.listAddon[index].isFavorite = true;
                  }

                  return BuildPhone(
                    controller: controller,
                    pathFile: controller.listAddon[index].pathUrl,
                    index: index,
                    onFavoriteTap: () {
                      controller.listAddon[index].isFavorite =
                          !controller.listAddon[index].isFavorite;
                      controller
                          .savePrefFavoriteItem(controller.listAddon[index]);
                      controller.listAddon.refresh();
                    },
                    addonsItem: controller.listAddon[index],
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
                if (controller.listAddon[index] == 'Ads') {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: NativeAdHomeWidget(
                        adItem:
                            nativeHomeAdControllerNew.getAdsByIncreaseIndex()),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    semanticContainer: false,
                  );
                } else {
                  var indexDownload = controller.listDownloaded.indexWhere(
                      (element) =>
                          element.id == controller.listAddon[index].itemId);
                  String pathFile = '';
                  if (indexDownload != -1) {
                    controller.listAddon[index].isDownloaded = true;
                    pathFile =
                        controller.listDownloaded[indexDownload].pathFile;
                  }

                  var indexFavorite = controller.listFavorite.indexWhere(
                      (element) =>
                          element.itemId == controller.listAddon[index].itemId);
                  if (indexFavorite != -1) {
                    controller.listAddon[index].isFavorite = true;
                  }
                  return BuildTablet(
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
                    },
                  );
                }
              }),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            addonsItem.itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                            ),
                          ),
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
                    NativeAdDetailWidget(
                        adItem: nativeDetailAdControllerNew
                            .getAdsByIncreaseIndex()),
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
                        // Container(
                        //   margin: EdgeInsets.all(10),
                        //   width: Get.width,
                        //   height: 45,
                        //   child: TextButton(
                        //     onPressed: () async {
                        //       !addonsItem.isDownloaded
                        //           ? DetailPage().downloadInstallAddon(
                        //               addonsItem,
                        //               isTablet: true,
                        //               isDetail: false)
                        //           : detailController.importToMinecraft(addonsItem.pathUrl);
                        //           // : print(addonsItem.pathUrl);
                        //     },
                        //     child: Text(
                        //       detailController.textButton.value,
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //     style: ButtonStyle(
                        //       foregroundColor: MaterialStateProperty.all<Color>(
                        //           kColorDownloadButtonForeground),
                        //       backgroundColor: MaterialStateProperty.all<Color>(
                        //           kColorDownloadButtonBackground),
                        //     ),
                        //   ),
                        // ),
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
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue.withOpacity(0.01),
                      child: addonsItem.htmlDescription.isNullOrBlank
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
    });
  }
}

class BuildPhone extends StatelessWidget {
  const BuildPhone(
      {Key key,
      @required this.controller,
      @required this.pathFile,
      @required this.index,
      @required this.onFavoriteTap,
      @required this.addonsItem,
      this.page})
      : super(key: key);

  final MainController controller;
  final String pathFile;
  final int index;
  final Function onFavoriteTap;
  final AddonsItem addonsItem;
  final String page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // key: ValueKey<int>(index),
      onTap: () {
        controller.countInterAd++;
        if (controller.countInterAd == 3) {
          controller.countInterAd = 0;
          Get.put(AdsController()).showIntersAds();
        }
        Get.to(() => DetailPage(
              addonsItem: addonsItem,
              pathFile: pathFile,
            )).whenComplete(() {
          print('dispose detail');
          nativeDetailAdControllerNew.requestAds();
          nativeHomeAdControllerNew.requestAds();
          MainController().listAddon.refresh();
          DetailController().isDownloaded.value = false;
        });
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
                //phone
                Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: SvgPicture.asset(
                        addonsItem.isFavorite ? kHeartFull : kHeartAround,
                        color: kColorLikeIcon,
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
                            width: Get.width * 0.64,
                            height: 60,
                            child: GestureDetector(
                              onTap: () => print(addonsItem.isFavorite),
                              child: Text(
                                addonsItem.itemName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                            )),
                        SizedBox(
                          width: Get.width * 0.64,
                          child: GestureDetector(
                            onTap: () => print(addonsItem.pathUrl),
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
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //todo: phone button
                        Container(
                          width: 110,
                          child: TextButton(
                            onPressed: () async {
                              addonsItem.pathUrl == null
                                  ? DetailPage().downloadInstallAddon(
                                      addonsItem,
                                      isDetail: false,
                                      isTablet: false,
                                      page: page,
                                      index: index)
                                  : DetailPage().dialogAskInstall(pathFile);
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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        semanticContainer: false,
      ),
    );
  }
}

class BuildTablet extends StatelessWidget {
  const BuildTablet(
      {Key key,
      @required this.controller,
      @required this.pathFile,
      @required this.index,
      @required this.onFavoriteTap,
      @required this.addonsItem,
      this.page})
      : super(key: key);

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
        if (controller.countInterAd == 3) {
          controller.countInterAd = 0;
          Get.put(AdsController()).showIntersAds();
        }
        MainPage().showDetailDialog(
          addonsItem: addonsItem,
          pathFile: pathFile,
        );
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
                        addonsItem.isFavorite ? kHeartFull : kHeartAround,
                        color: kColorLikeIcon,
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
                            width: Get.width * 0.30,
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
                          width: Get.width * 0.30,
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
                                  : DetailPage().dialogAskInstall(pathFile);
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
