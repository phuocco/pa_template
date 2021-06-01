import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/tutorial_module/tutorial_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class TutorialPage extends GetWidget<TutorialController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
        init: TutorialController(),
        builder: (_) {
          return tutorialWidget(GetPlatform.isAndroid
              ? """${'tutorial_addon'.tr}"""
              : """${'tutorial_addon_ios'.tr}""");

          // return DefaultTabController(
          //   length: 3,
          //   child: Scaffold(
          //     appBar: TabBar(
          //       labelStyle:
          //       TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          //       indicatorSize: TabBarIndicatorSize.tab,
          //       labelColor: Colors.black,
          //       labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
          //       tabs: <Tab>[
          //         Tab(text: 'ADDON/TEXTURE'),
          //         Tab(text: 'MAP/SEED'),
          //         Tab(text: 'SKIN'),
          //       ],
          //       controller: controller.tabController,
          //     ),
          //     body:  TabBarView(
          //       controller: controller.tabController,
          //       children: [
          //         tutorialWidget(GetPlatform.isAndroid ? """${'tutorial_addon'.tr}""" : """${'tutorial_addon_ios'.tr}"""),
          //         tutorialWidget(GetPlatform.isAndroid ? """${'tutorial_map_seed'.tr}""" : """${'tutorial_map_ios'.tr}"""),
          //         tutorialWidget(GetPlatform.isAndroid ? """${'tutorial_skin'.tr}""" : """${'tutorial_skin_ios'.tr}""")
          //       ],
          //     ),
          //   ),
          // );
        });
  }
}

Widget tutorialWidget(String type) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          HtmlWidget(
            type,
            customStylesBuilder: (element) {
              return null;
            },
            customWidgetBuilder: (element) {
              if (element.localName.contains('img')) {
                print(element.attributes['src']);
                return Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(element.attributes['src']),
                ));
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );
}
