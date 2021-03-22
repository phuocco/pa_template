import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_page.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalleryRating extends GetView<GalleryController> {
  final controller = Get.put(GalleryController());
  int page = 1;


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    page = 1;
    Get.find<GalleryController>().refreshGallery(1);
    Get.find<GalleryController>().getGallery(page, 1);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    page++;
    print('load more');
    loadMore();
  }

  void loadMore() async {
    await Get.find<GalleryController>().getGallery(page, 1);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    print("Tab rebuild");
    return Container(
      // key: key,
      child: GetX<GalleryController>(
        initState: (state) {
          Get.find<GalleryController>().getGallery(page, 1);
          print('hello request');
        },
        builder: (_) {
          if (controller.listCardNewest.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropMaterialHeader(
                color: Colors.white,
                backgroundColor: Color(0xff5f6368),
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: GridView.builder(
                  itemCount: controller.listCardRating.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 7 / 14,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GalleryItemPage(

                      index: index,
                      cardDetailModel: controller.listCardRating[index].card,
                      id: controller.listCardRating[index].id,
                      rateCount: controller.listCardRating[index].rateCount,
                      starAverage: controller.listCardRating[index].starAverage,
                    );
                  }
              ),
            );
          }
        },
      ),
    );
  }
}
