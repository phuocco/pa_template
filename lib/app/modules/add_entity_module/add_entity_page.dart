import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/models/new_creator.dart';
import 'package:mods_guns/widgets/switcher_button.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityPage extends GetWidget<AddEntityController> {
  final CreatorController creatorController = Get.find();
  final NewCreatorItem newCreatorItem;
  final int index;
  AddEntityPage({this.newCreatorItem, this.index});
  TextEditingController textCtrlName = TextEditingController();
  TextEditingController textCtrlIcon = TextEditingController();
  TextEditingController textCtrlSkin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textCtrlName.text = newCreatorItem.itemName;
    textCtrlIcon.text = newCreatorItem.itemIcon;
    textCtrlSkin.text = newCreatorItem.itemSkin;
    // controller.onStart();
    return Scaffold(
      appBar: AppBar(
        title: Text('AddEntity Page'),
        actions: [
          IconButton(
              onPressed: () {
                newCreatorItem.itemName = textCtrlName.text;
                newCreatorItem.itemIcon = textCtrlIcon.text;
                newCreatorItem.itemSkin = textCtrlSkin.text;
                creatorController.save(newCreatorItem, index);
                Get.back();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TextField(
              //   controller: textCtrlName,
              // ),
              // TextField(
              //   controller: textCtrlIcon,
              // ),
              // TextField(
              //   controller: textCtrlSkin,
              // ),
              SizedBox(height: 10),
              AddEntityRowTextField(
                property: 'Name',
                textEditingController: textCtrlName,
              ),
              SizedBox(height: 10),
              AddEntityRowSwitcher(
                property: 'Name',
                childWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddEntityRowTextField(
                      property: 'Icon',
                      textEditingController: textCtrlIcon,
                    ),
                    AddEntityRowTextField(
                      property: 'Skin',
                      textEditingController: textCtrlSkin,
                    ),
                  ],
                )
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColorAddEntity,
    );
  }
}

class AddEntityRowSwitcher extends StatelessWidget {
  final controller = Get.put(AddEntityController());
  final String property;
  final Widget childWidget;
  AddEntityRowSwitcher({this.property,this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: controller.isExpand.value ? 140 : 40,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 5,
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(property),
                          )),
                      Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: SwitcherButton(
                              onColor: Colors.blue,
                              offColor: Colors.red,
                              value: true,
                              onChange: (value) {
                                controller.setExpand(value);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.isExpand.value,
                  child: SizeTransition(
                    axisAlignment: 1.0,
                    sizeFactor: controller.animation,
                    child: childWidget
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class AddEntityRowTextField extends StatelessWidget {
  final String property;
  final TextEditingController textEditingController;
  AddEntityRowTextField({this.property, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(property),
                )),
            Flexible(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: kBackgroundColorAddEntity),
                ),
              ),
            ),
          ],
        ));
  }
}
