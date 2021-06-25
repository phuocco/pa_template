import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/models/new_creator.dart';
import 'package:mods_guns/widgets/switcher_button.dart';

class AddEntityPage extends GetWidget<AddEntityController> {
  final CreatorController creatorController = Get.find();
  final NewCreatorItem newCreatorItem;
  final int index;
  AddEntityPage({this.newCreatorItem, this.index});

  @override
  Widget build(BuildContext context) {
    var textCtrlName = TextEditingController();
    var textCtrlIcon = TextEditingController();
    var textCtrlSkin = TextEditingController();

    textCtrlName.text = newCreatorItem.itemName;
    textCtrlIcon.text = newCreatorItem.itemIcon;
    textCtrlSkin.text = newCreatorItem.itemSkin;

    var textCtrlId = TextEditingController();
    var textCtrlPower = TextEditingController();
    var textCtrlGravity = TextEditingController();
    var textCtrlDamage = TextEditingController();
    var textCtrlShotDelay = TextEditingController();

    //todo assign



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
              //fixme: id field
              Container(
                  height: 90,
                  width: Get.width,
                  padding: EdgeInsets.only(left: 10,bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text('ID'),
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  controller: textCtrlId,
                                  onChanged: (value){
                                    controller.setTextId(value);
                                  },
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
                        ),
                      ),
                      Obx(() => Text('Command /give @pamobile:' + controller.textId.value),),
                    ],
                  )),

              SizedBox(height: 10),

              AddEntityRowTextField(
                property: 'Shot Delay',
                textEditingController: textCtrlShotDelay,
              ),
              SizedBox(height: 10),

              SizedBox(height: 10),

              AddEntityRowSwitcher(
                property: 'Test',
                type: 'KnockBack',
                isChild: false,
              ),
              SizedBox(height: 10),
              AddEntityRowExpand(
                property: 'Explode',
                expandHeight: 140,
                childWidget: Container(
                  color: Colors.blue,
                  height: 100,
                  width: Get.width,
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddEntityRowSwitcher(
                        property: 'Abc',
                        type: 'Teleport',
                        isChild: true,
                      ),
                      AddEntityRowTextField(
                        property: 'Shot Delay',
                        textEditingController: textCtrlShotDelay,
                      ),
                    ],
                  ),
                ),
              ),

          //region test
              TextField(
                controller: textCtrlName,
              ),
              TextField(
                controller: textCtrlIcon,
              ),
              TextField(
                controller: textCtrlSkin,
              ),
              //endregion

            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColorAddEntity,
    );
  }
}



class AddEntityRowSwitcher extends StatelessWidget {
  final String property;
  final String type;
  final bool isChild;
  final controller = Get.put(AddEntityController());
  AddEntityRowSwitcher({this.property, this.type,this.isChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(isChild?0:5)),
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
                            controller.setSwitch(type, value);
                          },
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEntityRowExpand extends StatelessWidget {
  final String property;
  final Widget childWidget;
  final String type;
  final double expandHeight;
  final controller = Get.put(AddEntityController());
  AddEntityRowExpand({this.property, this.childWidget, this.type, this.expandHeight});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: controller.isExpand.value ? expandHeight : 40,
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
                                // controller.setExpand(value);
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
                        child: childWidget),
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
        height: 60,
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
