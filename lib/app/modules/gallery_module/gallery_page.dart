import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_controller.dart';
import 'package:pa_template/app/modules/gallery_module/keep_alive_wrapper.dart';

import 'gallery_tab.dart';

class GalleryPage extends GetView<GalleryController> {
  final controller = Get.put(GalleryController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xff5f6368)),
          child: TabBar(
            indicatorColor: Colors.black,
            controller: controller.tabController,
            tabs: [
              Container(
                height: 40,
                child: Tab(
                  text: 'NEWEST',
                ),
              ),
              Container(
                height: 40,
                child: Tab(
                  text: 'RATING',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: <Widget>[
              KeepAliveWrapper(child: GalleryTab(0),),
              KeepAliveWrapper(child: GalleryTab(1),),
            ],
          ),
        ),
      ],
    );
  }
}
