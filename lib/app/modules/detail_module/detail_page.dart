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
    String filePathSkin = '/storage/emulated/0/Android/data/co.pamobile.yugioh.cardmaker/files/captainamerica.mcpack';
    String linkAddon = 'https://files.mcpedata.com/mcpemods/files/FurnicraftAddon113.addon';
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
                  ));
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
                  ));
                }
              }), child: Text('install addon')),
            ],
          ),
        ),
      ),
    );
  }
}
