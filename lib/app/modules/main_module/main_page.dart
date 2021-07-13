import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mods_guns/app/modules/about_module/about_page.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/app/modules/detail_module/detail_page.dart';
import 'package:mods_guns/app/modules/downloaded_module/downloaded_page.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_controller.dart';
import 'package:mods_guns/app/modules/favorite_module/favorite_page.dart';
import 'package:mods_guns/app/modules/home_module/home_controller.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/app/modules/question_module/question_page.dart';
import 'package:mods_guns/app/modules/search_module/search_page.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/app/theme/app_text_theme.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/constants/const_drawer.dart';
import 'package:mods_guns/controllers/ads_controller.dart';
import 'package:mods_guns/controllers/native_ad_controller_new.dart';
import 'package:mods_guns/models/addons_item.dart';
import 'package:mods_guns/widgets/base_banner.dart';
import 'package:mods_guns/widgets/loading_native_ad_widget.dart';
import 'package:mods_guns/widgets/native_ad_detail_widget.dart';
import 'package:mods_guns/widgets/native_ad_home_widget.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainController());

  final AdsController adsController = Get.find();
  final DetailController detailController = Get.find();
  final NativeAdControllerNew nativeAdControllerNew = Get.find();
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.onStart();

    return GetPlatform.isAndroid
        ? MainPageDownload()
        : Container(
            color: Colors.red,
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Obx(() => IndexedStack(
                      index: controller.indexStack.value,
                      children: [
                        MainPageDownload(),
                        MainPageItemId(),
                        SearchPage(),
                        DownloadedPage(),
                      ],
                    ),),
                  ),
                  // Expanded(
                  //     child: GetX<MainController>(
                  //   initState: controller.initPage2(),
                  //   builder: (_) {
                  //     return _.listPages2[_.selectingPageNew2];
                  //   },
                  // )),
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
                      MaterialButton(
                        minWidth: 40,
                        // onPressed: () =>
                        //     controller.selectPageNew2('Main Page Download'),
                        onPressed: () => controller.setIndexStack(0),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/icons/ic_hottest.png',
                                width: 28,
                                height: 28,
                                color: controller.indexStack.value ==
                                        0
                                    ? kColorAppbar
                                    : Colors.grey,
                              )),
                              Text('HOTTEST',
                                  style: controller.indexStack.value ==
                                      0
                                      ? selectedTab
                                      : unselectedTab),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        // onPressed: () =>
                        //     controller.selectPageNew2('Main Page ItemId'),
                        onPressed: () => controller.setIndexStack(1),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/icons/ic_newest.png',
                                width: 28,
                                height: 28,
                                color: controller.indexStack.value ==
                                    1
                                    ? kColorAppbar
                                    : Colors.grey,
                              )),
                              Text('NEWEST',
                                  style: controller.indexStack.value ==
                                      1
                                      ? selectedTab
                                      : unselectedTab),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        // onPressed: () =>
                        //     controller.selectPageNew2('Search Page'),
                        onPressed: () => controller.setIndexStack(2),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/icons/ic_search.png',
                                width: 28,
                                height: 28,
                                color: controller.indexStack.value ==
                                    2
                                    ? kColorAppbar
                                    : Colors.grey,
                              )),
                              Text('SEARCH',
                                  style: controller.indexStack.value ==
                                      2
                                      ? selectedTab
                                      : unselectedTab),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        // onPressed: () =>
                        //     controller.selectPageNew2('Downloaded Page'),
                        onPressed: () => controller.setIndexStack(3),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/icons/ic_manage.png',
                                width: 28,
                                height: 28,
                                color: controller.indexStack.value ==
                                    3
                                    ? kColorAppbar
                                    : Colors.grey,
                              )),
                              Text('MANAGE',
                                  style: controller.indexStack.value ==
                                      3
                                      ? selectedTab
                                      : unselectedTab),
                            ],
                          ),
                        ),
                      ),
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

class MainPageDownload extends StatelessWidget {
  MainPageDownload();

  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listAddon.length == 0) {
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
                      controller.listAddonNew.refresh();
                    },
                  );
                }
              });
    });
  }
}

class MainPageItemId extends StatelessWidget {
  MainPageItemId();

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
                  return BuildPhone(
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

                  return BuildTablet(
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

class BuildPhone extends StatelessWidget {
  BuildPhone(
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
      // key: ValueKey<int>(index),
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
        Get.to(() => DetailPage(
              addonsItem: addonsItem,
              pathFile: pathFile,
            )).whenComplete(() {
          print('dispose detail');
          nativeDetailAdControllerNew.requestAds();
          nativeHomeAdControllerNew.requestAds();
          MainController().listAddon.refresh();
          MainController().listAddonNew.refresh();
          detailController.isDownloaded.value = false;

          if (detailController.cancelToken.isCancelled) {
            detailController.dio.close();
            detailController.cancelToken.cancel();
          }
          detailController.progress.value = 0;
          detailController.isDownloading.value = false;
          // DetailController().isDownloaded.value = false;

          nativeDetailAdControllerNew.listAds.forEach((element) {
            print("detail " + element.hashCode.toString());
          });
          nativeHomeAdControllerNew.listAds.forEach((element) {
            print("home " + element.hashCode.toString());
          });
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
                            width: Get.width * 0.50,
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
                          width: Get.width * 0.50,
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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        semanticContainer: false,
      ),
    );
  }
}

class BuildTablet extends StatelessWidget {
  BuildTablet(
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
