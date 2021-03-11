import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryPage extends GetWidget<GalleryController> {
  final controller = Get.put(GalleryController());
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Gallery'),);
  }
}
