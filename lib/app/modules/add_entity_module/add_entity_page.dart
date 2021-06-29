import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/add_entity_module/add_entity_controller.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/app/theme/app_colors.dart';
import 'package:mods_guns/models/creator.dart';
import 'package:mods_guns/models/new_creator.dart';
import 'package:mods_guns/widgets/switcher_button.dart';

class AddEntityPage extends GetWidget {
  final AddEntityController controller = Get.put(AddEntityController());
  final CreatorController creatorController = Get.find();
  final CreatorItem creatorItem;
  final int index;
  AddEntityPage({this.creatorItem, this.index});

  @override
  Widget build(BuildContext context) {

    //todo assign
    // controller.onStart();
    controller.getData(creatorController,creatorItem);
    return Scaffold(
      appBar: AppBar(
        title: Text('AddEntity Page'),
        actions: [
          IconButton(
              onPressed: () {
               //save
               //  creatorController.save(newCreatorItem, index);
               //  controller.sendBackCreatorItem(creatorController, creatorItem);
               //  Get.back();
                print(creatorItem.toJson());
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
                                  controller: controller.textCtrlId,
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

              //fixme: name field
              AddEntityRowTextField(
                property: 'Name',
                textEditingController: controller.textCtrlName,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme: power field
              AddEntityRowTextField(
                property: 'Power',
                textEditingController: controller.textCtrlPower,
                isChild: false,
              ),

              SizedBox(height: 10),
              //fixme: gravity field
              AddEntityRowTextField(
                property: 'Gravity',
                textEditingController: controller.textCtrlGravity,
                isChild: false,
              ),
              SizedBox(height: 10),
              //fixme shot delay
              AddEntityRowTextField(
                property: 'Shot Delay',
                textEditingController: controller.textCtrlShotDelay,
                isChild: false,
              ),
              SizedBox(height: 10),
              //fixme knock back
              AddEntityRowSwitcher(
                property: 'Knock back',
                type: 'KnockBack',
                value: controller.isKnockBack.value,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme catch fire
              AddEntityRowSwitcher(
                property: 'Catch Fire',
                type: 'CatchFire',
                value: controller.isCatchFire.value,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme teleport
              Obx(() =>AddEntityRowSwitcher(
                property: 'Teleport',
                type: 'Teleport',
                value: controller.isTeleport.value,
                isChild: false,
              ),),


              SizedBox(height: 10),
              //fixme explode
              AddEntityRowExpand(
                property: 'Explode',
                expandHeight: 140,
                childWidget: Container(
                  height: 100,
                  width: Get.width,
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddEntityRowTextField(
                        property: 'Power',
                        textEditingController: controller.textCtrlExplodePower,
                        isChild: true,
                      ),
                      AddEntityRowSwitcher(
                        property: 'Causes Fire',
                        type: 'ExplodeCausesFire',
                        value: controller.isExplodeCausesFire.value,
                        isChild: true,
                        isLast: true,
                      ),
                    ],
                  ),
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
  final String property;
  final String type;
  final bool value;
  final bool isChild;
  final bool isLast;
  final AddEntityController controller = Get.find();
  AddEntityRowSwitcher({this.property, this.type,this.isChild, this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: isLast ?BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)) : BorderRadius.all(Radius.circular(isChild? 0: 5)),
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
                        child: Text(property + " " + value.toString()),
                      )),
                  Flexible(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Switch(
                          value: value,
                          onChanged: (bool vl) {
                            controller.isTeleport.value = vl;
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
  final bool isChild;
  AddEntityRowTextField({this.property, this.textEditingController, this.isChild});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(isChild ? 0 : 5)),
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
