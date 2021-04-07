import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
import 'package:pa_template/models/addons_item.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailPage extends StatelessWidget {
  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    String linkSkin =
        'https://files.mcpedata.com/mcpeskins/files/movies/captainamerica.png';
    String linkAddon =
        'https://files.mcpedata.com/mcpemods/files/FurnicraftAddon113.addon';
    String linkMapSeed =
        'https://files.mcpedata.com/mcpeseeds/files/MassiveTemple.zip';
    String linkTexture =
        'https://files.mcpedata.com/mcpetextures/files/RUSPEShadersV143.zip';
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Container(
        child: Obx(
          () => ListView.builder(
              itemCount: controller.listAddon.length,
              itemBuilder: (context, index) {
                String type = 'type';

                switch(controller.listAddon[index].typeId){
                  case '1':
                    type = 'Addon';

                    break;
                  case '3':
                  case '6':
                    type = 'mapseed';
                    break;
                  case '4':
                    type = 'skin';
                    break;
                  case '5':
                    type = 'texture';
                    break;

                }
                return GestureDetector(
                  onTap: (){
                    Get.dialog(AlertDialog(
                      title: Text(type),
                      content: Text(controller.listAddon[index].fileUrl),
                      actions: [
                        TextButton(onPressed: (){
                          switch(controller.listAddon[index].typeId){
                            case '1':
                              type = 'Addon';
                              controller.installAddon(controller.listAddon[index].fileUrl).then((value){
                                dialogAskImport();
                              });
                              break;
                            case '3':
                            case '6':
                              type = 'mapseed';
                              controller.installMapSeed(controller.listAddon[index].fileUrl).then((value){
                                dialogAskImport();
                              });
                              break;
                            case '4':
                              type = 'skin';
                              controller.installSkin(controller.listAddon[index].fileUrl).then((value){
                                dialogAskImport();
                              });
                              break;
                            case '5':
                              type = 'texture';
                              controller.installTexture(controller.listAddon[index].fileUrl).then((value){
                                dialogAskImport();
                              });
                              break;

                          }
                        }, child: Text('install'))
                      ],
                    ));
                  },
                  child: ListTile(
                    leading: Text(type),
                    title: Text(controller.listAddon[index].fileUrl),

                  ),
                );
              }),
        ),
      ),
    );
  }
  dialogAskImport(){
    if(controller.isDownloaded.value){
      Get.back();
      Get.dialog(AlertDialog(
        title: Text('File downloaded'),
        content: Text('Do you want to install now?'),
        actions: [
          TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
          TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install skin')),
        ],
      ),barrierDismissible: false);
    }
  }
}


// TextButton(onPressed: () => controller.installSkin(linkSkin).then((value){
// if(controller.isDownloaded.value){
// Get.dialog(AlertDialog(
// title: Text('File downloaded'),
// content: Text('Do you want to install now?'),
// actions: [
// TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
// TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install skin')),
// ],
// ),barrierDismissible: false);
// }
// }), child: Text('install skin')),
// TextButton(onPressed: () => controller.installAddon(linkAddon).then((value){
// if(controller.isDownloaded.value){
// Get.dialog(AlertDialog(
// title: Text('File downloaded'),
// content: Text('Do you want to install now?'),
// actions: [
// TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
// TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),
// ],
// ),barrierDismissible: false);
// }
// }), child: Text('install addon')),
// TextButton(onPressed: () => controller.installMapSeed(linkMapSeed).then((value){
// if(controller.isDownloaded.value){
// Get.dialog(AlertDialog(
// title: Text('File downloaded'),
//
// content: Text('Do you want to install now?'),
// actions: [
// TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
// TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),
//
// ],
// ),barrierDismissible: false);
// }
// }), child: Text('install map/seed')),
// TextButton(onPressed: () => controller.installTexture(linkTexture).then((value){
// if(controller.isDownloaded.value){
// Get.dialog(AlertDialog(
// title: Text('File downloaded'),
// content: Text('Do you want to install now?'),
// actions: [
// TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
// TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),
// ],
// ),barrierDismissible: false);
// }
// }), child: Text('install texture')),
