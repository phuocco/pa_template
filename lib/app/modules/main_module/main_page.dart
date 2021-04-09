import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/home_module/home_page.dart';
import 'package:pa_template/app/modules/main_module/main_controller.dart';
import 'package:pa_template/app/modules/test_native_module/test_native_page.dart';
import 'package:pa_template/app/routes/app_pages.dart';
import 'package:pa_template/controllers/ads_controller.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/widgets/base_native.dart';


class MainPage extends StatelessWidget{

  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() =>
        ListView.builder(
            itemCount: controller.listAddon.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: Text(controller.listAddon[index].authorName),
                title: Text(controller.listAddon[index].itemName),
              );
            }
        ),
      );
  }
}
