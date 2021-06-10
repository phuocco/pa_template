import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mods_guns/app/data/provider/home_provider.dart';
import 'package:mods_guns/app/data/repository/home_repository.dart';
import 'package:mods_guns/app/modules/home_module/home_controller.dart';
import 'package:mods_guns/app/modules/more_apps_module/more_apps_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/constants/const_drawer.dart';
import 'package:mods_guns/models/more_apps.dart';

class LoadingNativeAdWidget extends StatelessWidget {
  final MoreAppsController moreAppsController = Get.find();

  final String adType;
  LoadingNativeAdWidget({this.adType});

  MoreApp itemAdsDefault() {
    return GetPlatform.isAndroid
        ? MoreApp(
            'assets/images/game_tuner.png',
            'Game Tuner',
            'co.pamobile.gamelauncher',
            'assets/images/banner_game.jpg',
            'Game Launcher Tuner is an ultimate app to boost your device memory for gaming')
        : MoreApp(
            'assets/images/devilhunter.jpg',
            'Devil Hunter:Monster Shooter',
            'co.pamobile.gamestudio.fps.devilhunter',
            'assets/images/banner_game2.jpg',
            'The hunt for monsters from the darkness, strike fear to every enemies you face!!');
  }

  @override
  Widget build(BuildContext context) {
    var listData = moreAppsController.listMoreApp;
    var itemAd;
    if (listData.length == 0) {
      itemAd = itemAdsDefault();
    } else {
      itemAd = listData[Random().nextInt(listData.length)];
    }

    return GestureDetector(
      onTap: () {

        if (GetPlatform.isAndroid) {
          LaunchReview.launch(
              androidAppId: itemAd.packageName,
              writeReview: false);
        } else  {
          HomeProvider()
              .fetchAppInfo(itemAd.packageName)
              .then((value) => {
            LaunchReview.launch(
                iOSAppId:
                '${value.results[0].trackId}',
                writeReview: false),
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [containerLoadingAd(context, itemAd, adType)],
      ),
    );
  }
}

Widget containerLoadingAd(BuildContext context, MoreApp itemAd, String adType) {
  switch (adType) {
    case "Home":
      print("width "+ Get.width.toString());
      return Container(
        child: Column(
          children: [
            Stack(
              children: [
                itemAd.banner == ''
                    ? AspectRatio(
                  aspectRatio: Get.width <= 500 ? 33/14 : 35 / 18,
                  child: itemAd.icon.trimLeft().trimRight().startsWith('assets/')
                      ? Image.asset(
                    itemAd.icon.trimLeft().trimRight(),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.none,
                  )
                      : CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      "assets/images/card_holder.png",
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.none,
                    ),
                    imageUrl: itemAd.icon.trimLeft().trimRight(),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.none,
                  ),)
                    : AspectRatio(
                    aspectRatio: Get.width <= 500 ? 33/14 : 35 / 18,
                    child: itemAd.banner
                        .trimLeft()
                        .trimRight()
                        .startsWith('assets/')
                        ? Image.asset(
                      itemAd.banner.trimLeft().trimRight(),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    )
                        : CachedNetworkImage(
                      placeholder: (context, url) => Image.asset(
                        "assets/images/card_holder.png",
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.none,
                      ),
                      imageUrl: itemAd.banner.trimLeft().trimRight(),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    )),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 18,
                    width: 18,
                    color: kColorAppbar,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text('Ad', style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ),
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
                          width: context.isPhone ? Get.width * 0.50 : Get.width * 0.25,
                          height: 55,
                          child: Text(
                            itemAd.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          )),
                      SizedBox(
                        width: context.isPhone ? Get.width * 0.50 : Get.width * 0.25,
                        child: Text(
                          itemAd.description,
                          maxLines : Get.width <= 800  ? 2 : 1,
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

                            if (GetPlatform.isAndroid) {
                              LaunchReview.launch(
                                  androidAppId: itemAd.packageName,
                                  writeReview: false);
                            } else {
                              HomeProvider()
                                  .fetchAppInfo(itemAd.packageName)
                                  .then((value) => {
                                LaunchReview.launch(
                                    iOSAppId:
                                    '${value.results[0].trackId}',
                                    writeReview: false),
                              });
                            }
                          },
                          child: Text(
                            'install'.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                kColorDownloadButtonForeground),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kColorInstallButtonBackground),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    case "Detail":
      return Container(
        color: kBackgroundNativeAdColor,
        height: context.isPhone || GetPlatform.isAndroid ? 350: 370,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.black.withOpacity(0.3),
                  child:
                      Stack(
                        children: [
                          itemAd.icon.trimLeft().trimRight().startsWith('assets/')
                              ? Image.asset(
                            itemAd.icon.trimLeft().trimRight(),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                          )
                              : CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              "assets/images/card_holder.png",
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.none,
                            ),
                            imageUrl: itemAd.icon.trimLeft().trimRight(),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              height: 18,
                              width: 18,
                              color: kColorAppbar,
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text('Ad', style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                        ],
                      ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemAd.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 220,

              child: itemAd.banner == ''
                  ? AspectRatio(
                aspectRatio: 35 / 18,
                child: itemAd.icon.trimLeft().trimRight().startsWith('assets/')
                    ? Image.asset(
                  itemAd.icon.trimLeft().trimRight(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                )
                    : CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    "assets/images/card_holder.png",
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                  ),
                  imageUrl: itemAd.icon.trimLeft().trimRight(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                ),)
                  : AspectRatio(
                  aspectRatio: 35 / 18,
                  child: itemAd.banner
                      .trimLeft()
                      .trimRight()
                      .startsWith('assets/')
                      ? Image.asset(
                    itemAd.banner.trimLeft().trimRight(),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.none,
                  )
                      : CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      "assets/images/card_holder.png",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                    imageUrl: itemAd.banner.trimLeft().trimRight(),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.none,
                  )),
            ),
           
            Expanded(
              child: Text(
                itemAd.description ?? "",
                maxLines: 2,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: kColorDownloadButtonBackground,
                    width: 1,
                  )),
              width: Get.width,
              height: 45,
              child: TextButton(
                onPressed: () async {
                  if (GetPlatform.isAndroid) {
                    LaunchReview.launch(
                        androidAppId: itemAd.packageName,
                        writeReview: false);
                  } else {
                    HomeProvider()
                        .fetchAppInfo(itemAd.packageName)
                        .then((value) => {
                      LaunchReview.launch(
                          iOSAppId:
                          '${value.results[0].trackId}',
                          writeReview: false),
                    });
                  }
                },
                child: Text(
                  'download'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      kColorDownloadButtonForeground),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kColorDownloadButtonBackground),
                ),
              ),
            ),
          ],
        ),
      );
    case "Exit":
      return Container(
        color: kBackgroundNativeAdColor,
        height: context.isPhone || GetPlatform.isAndroid ? 330: 370,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  color: Colors.black.withOpacity(0.3),
                  child:
                  Stack(
                    children: [
                      itemAd.icon.trimLeft().trimRight().startsWith('assets/')
                          ? Image.asset(
                        itemAd.icon.trimLeft().trimRight(),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.none,
                      )
                          : CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(
                          "assets/images/card_holder.png",
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.none,
                        ),
                        imageUrl: itemAd.icon.trimLeft().trimRight(),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 18,
                          width: 18,
                          color: kColorAppbar,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text('Ad', style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemAd.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: Get.width <= 500 ? 200 : 220,
              child: itemAd.banner == ''
                  ? AspectRatio(
                aspectRatio: 35 / 18,
                child: itemAd.icon.trimLeft().trimRight().startsWith('assets/')
                    ? Image.asset(
                  itemAd.icon.trimLeft().trimRight(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                )
                    : CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    "assets/images/card_holder.png",
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                  ),
                  imageUrl: itemAd.icon.trimLeft().trimRight(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                ),)
                  : AspectRatio(
                  aspectRatio: 35 / 18,
                  child: itemAd.banner
                      .trimLeft()
                      .trimRight()
                      .startsWith('assets/')
                      ? Image.asset(
                    itemAd.banner.trimLeft().trimRight(),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.none,
                  )
                      : CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      "assets/images/card_holder.png",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                    imageUrl: itemAd.banner.trimLeft().trimRight(),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.none,
                  )),
            ),
            Expanded(
              child: Text(
                itemAd.description ?? "",
                maxLines: 2,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: kColorDownloadButtonBackground,
                    width: 1,
                  )),
              width: Get.width,
              height: 45,
              child: TextButton(
                onPressed: () async {
                  if (GetPlatform.isAndroid) {
                    LaunchReview.launch(
                        androidAppId: itemAd.packageName,
                        writeReview: false);
                  } else {
                    HomeProvider()
                        .fetchAppInfo(itemAd.packageName)
                        .then((value) => {
                      LaunchReview.launch(
                          iOSAppId:
                          '${value.results[0].trackId}',
                          writeReview: false),
                    });
                  }
                },
                child: Text(
                  'download'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      kColorDownloadButtonForeground),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kColorDownloadButtonBackground),
                ),
              ),
            ),
          ],
        ),
      );
  }
  return SizedBox();
}
