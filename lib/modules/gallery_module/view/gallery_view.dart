import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/gallery_module/controller/gallery_controller.dart';

class GalleryView extends StatelessWidget {
  final controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GetX<GalleryController>(
            builder: (controller) {
              if (controller.galleryList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 5,
                  children:
                      List.generate(controller.galleryList.length, (index) {
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
                          Text(controller.galleryList[index].id),
                          Text(controller.galleryList[index].name),
                        ],
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
