import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/theme/app_colors.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainController());
  final detailController = Get.put(DetailController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => ListView.builder(
          itemCount: controller.listAddon.length,
          itemBuilder: (context, index) {
            return Card(
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
                                  width: Get.width * 0.65,
                                  height: 60,
                                  child: Text(
                                    controller.listAddon[index].itemName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                  )),
                              SizedBox(
                                width: Get.width * 0.65,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: ()async {
                                  detailController.installAddon(controller.listAddon[index].fileUrl).then((value) {
                                    return GetPlatform.isAndroid ? dialogAskImport() : detailController.importToMinecraft(detailController.finalPath.value);
                                  });
                                },
                                child: Text('DOWNLOAD'),
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
                                    controller.listAddon[index].downloadCount,
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
            );

          }),
    );
  }
  dialogAskImport(){
    if(detailController.isDownloaded.value){
      Get.back();
      Get.dialog(AlertDialog(
        title: Text('File downloaded'),
        content: Text('Do you want to install now?'),
        actions: [
          TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
          TextButton(onPressed:() => detailController.importToMinecraft(detailController.finalPath.value), child: Text('Install skin')),
        ],
      ),barrierDismissible: false);
    }
  }
}
