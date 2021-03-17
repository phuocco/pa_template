

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_page.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_controller.dart';

class GalleryTab extends GetView<GalleryController> {
  final controller = Get.put(GalleryController());
  final int sortType;

  GalleryTab(this.sortType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<GalleryController>(
        initState: (state) {
          Get.find<GalleryController>().getGallery(sortType);
        },
        builder: (_) {
          if (controller.listCard.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
                itemCount: controller.listCard.length,
                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 7 / 14,
              crossAxisSpacing: 20,
              mainAxisSpacing: 15,
            ),
                itemBuilder: (BuildContext context, int index) {
                  return GalleryItemPage(
                    galleryTab: this,
                    index: index,
                    cardDetailModel: controller.listCard[index].card,
                    id: controller.listCard[index].id,
                    rateCount: controller.listCard[index].rateCount,
                    starAverage: controller.listCard[index].starAverage,
                  );
                }
            );

          }
        },
      ),
    );
  }
}