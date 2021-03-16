

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 5,
              children: List.generate(controller.listCard.length, (index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ]),
                  child: Column(
                    children: [
                      Text(controller.listCard[index].category),
                      Text(controller.listCard[index].id),
                      Text(controller.listCard[index].card.cardName),
                    ],
                  ),
                );
              }),
            );
          }
        },
      ),
    );
  }
}