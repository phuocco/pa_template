import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/models/addons_item.dart';
import 'package:pa_template/widgets/native_ad_detail_widget.dart';
import 'package:pa_template/widgets/native_ad_home_widget.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailPage extends StatelessWidget {
  final controller = Get.put(DetailController());
  final adsController = Get.put(AdsController());
  final AddonsItem addonsItem;

  DetailPage({this.addonsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorAppbar,
        title: Text(addonsItem.itemName),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                nativeAdsController: adsController.listNativeAdsDetailController[0]),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: Get.width,
                  height: 45,
                  child: TextButton(
                    onPressed: () async => downloadInstallAddon(addonsItem.fileUrl),
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

  downloadInstallAddon(String link) async {
    print('a');
    controller.installAddon(link).then((value) {
      return GetPlatform.isAndroid
          ? dialogAskImport()
          : controller.importToMinecraft(controller.finalPath.value);
    });
  }

  dialogAskImport() {
    print('aa');
    if (controller.isDownloaded.value) {
      Get.back();
      Get.dialog(
          AlertDialog(
            title: Text('File downloaded'),
            content: Text('Do you want to install now?'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
              TextButton(
                  onPressed: () =>
                      controller.importToMinecraft(controller.finalPath.value),
                  child: Text('Install skin')),
            ],
          ),
          barrierDismissible: false);
    }
  }
}
