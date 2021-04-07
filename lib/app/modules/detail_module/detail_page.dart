import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/detail_module/detail_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailPage extends StatelessWidget {
  final controller = Get.put(DetailController());
  @override
  Widget build(BuildContext context) {
    String linkSkin = 'https://files.mcpedata.com/mcpeskins/files/movies/captainamerica.png';
    String linkAddon = 'https://files.mcpedata.com/mcpemods/files/FurnicraftAddon113.addon';
    String linkMapSeed = 'https://files.mcpedata.com/mcpeseeds/files/MassiveTemple.zip';
    String linkTexture = 'https://files.mcpedata.com/mcpetextures/files/RUSPEShadersV143.zip';
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(linkSkin),
              TextButton(onPressed: () => controller.installSkin(linkSkin).then((value){
                if(controller.isDownloaded.value){
                  Get.dialog(AlertDialog(
                    title: Text('File downloaded'),
                    content: Text('Do you want to install now?'),
                    actions: [
                      TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
                      TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install skin')),
                    ],
                  ),barrierDismissible: false);
                }
              }), child: Text('install skin')),
              SizedBox(height: 20,),
              Text(linkAddon),
              TextButton(onPressed: () => controller.installAddon(linkAddon).then((value){
                if(controller.isDownloaded.value){
                  Get.dialog(AlertDialog(
                    title: Text('File downloaded'),
                    content: Text('Do you want to install now?'),
                    actions: [
                      TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
                      TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),
                    ],
                  ),barrierDismissible: false);
                }
              }), child: Text('install addon')),
              SizedBox(height: 20,),

              Text(linkMapSeed),
              TextButton(onPressed: () => controller.installMapSeed(linkMapSeed).then((value){
                if(controller.isDownloaded.value){
                  Get.dialog(AlertDialog(
                    title: Text('File downloaded'),

                    content: Text('Do you want to install now?'),
                    actions: [
                      TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
                      TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),

                    ],
                  ),barrierDismissible: false);
                }
              }), child: Text('install map/seed')),

              Text(linkTexture),
              TextButton(onPressed: () => controller.installTexture(linkTexture).then((value){
                if(controller.isDownloaded.value){
                  Get.dialog(AlertDialog(
                    title: Text('File downloaded'),
                    content: Text('Do you want to install now?'),
                    actions: [
                      TextButton(onPressed:() => Get.back(), child: Text('Cancel')),
                      TextButton(onPressed:() => controller.importToMinecraft(controller.finalPath.value), child: Text('Install')),
                    ],
                  ),barrierDismissible: false);
                }
              }), child: Text('install texture')),
            ],
          ),
        ),
      ),
    );
  }
}
