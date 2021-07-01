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
    controller.getData(creatorController, creatorItem);
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
                  padding: EdgeInsets.only(left: 10, bottom: 5),
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
                              flex: 1,
                              child: Text('ID'),
                            ),
                            Flexible(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  controller: controller.idController,
                                  onChanged: (value) {
                                    controller.setTextId(value);
                                    controller.idController.value =
                                        TextEditingValue(
                                            text: value,
                                            selection: TextSelection(
                                                baseOffset: value.length,
                                                extentOffset: value.length));
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
                      Obx(
                        () => Text(
                          'Command /give @pamobile:' + controller.textId.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10),

              //fixme: name field
              AddEntityRowTextField(
                property: 'Name',
                textEditingController: controller.nameController,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme: texture field
              AddEntityRowTexture(
                property: 'Texture',
                controller: controller,
                creatorItem: creatorItem,
              ),
              SizedBox(height: 10),

              //fixme: power field
              AddEntityRowTextField(
                property: 'Power',
                textEditingController: controller.powerController,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme: gravity field
              AddEntityRowTextField(
                property: 'Gravity',
                textEditingController: controller.gravityController,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme: damage field
              AddEntityRowTextField(
                property: 'Damage',
                textEditingController: controller.damageController,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme shot delay
              AddEntityRowTextField(
                property: 'Shot Delay',
                textEditingController: controller.shotDelayController,
                isChild: false,
              ),
              SizedBox(height: 10),

              //fixme knock back
              Obx(
                () => AddEntityRowSwitcher(
                  property: 'Knock back',
                  type: 'KnockBack',
                  value: controller.isKnockBack.value,
                  isChild: false,
                ),
              ),
              SizedBox(height: 10),
              //fixme catch fire
              Obx(
                () => AddEntityRowSwitcher(
                  property: 'Catch fire',
                  type: 'CatchFire',
                  value: controller.isCatchFire.value,
                  isChild: false,
                ),
              ),
              SizedBox(height: 10),
              //fixme teleport
              Obx(
                () => AddEntityRowSwitcher(
                  property: 'Teleport',
                  type: 'Teleport',
                  value: controller.isTeleport.value,
                  isChild: false,
                ),
              ),
              SizedBox(height: 10),

              //fixme explode
              Obx(
                () => AddEntityRowExpand(
                  property: 'Explode',
                  type: 'Explode',
                  value: controller.isExplode.value,
                  heightExpand: 180,
                  childWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddEntityRowSwitcher(
                        property: 'Causes Fire',
                        type: 'ExplodeCausesFire',
                        value: controller.isCauseFire.value,
                        isChild: true,
                      ),
                      AddEntityRowTextField(
                        property: 'Power',
                        textEditingController:
                            controller.explodePowerController,
                        isChild: true,
                      ),
                    ],
                  ),
                ),
              ),
              // Obx(() =>AddEntityRowRecipe()),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColorAddEntity,
    );
  }
}

class AddEntityRowRecipe extends StatelessWidget {
  AddEntityRowRecipe();
  final AddEntityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(height:10, color: controller.isRecipe.value ? Colors.blue : Colors.red);
  }
}


class AddEntityRowSwitcher extends StatelessWidget {
  final String property;
  final String type;
  final bool value;
  final bool isChild;
  final bool isLast;
  final AddEntityController controller = Get.find();
  AddEntityRowSwitcher(
      {this.property,
      this.type,
      this.isChild,
      this.value,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: Get.width,
      padding:
          !isChild ? EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: isLast
            ? BorderRadius.only(
                bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
            : BorderRadius.all(Radius.circular(isChild ? 0 : 5)),
        color: Colors.white,
      ),
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
                      child: Switch(
                        value: value,
                        onChanged: (bool vl) {
                          // controller.isTeleport.value = vl;
                          controller.setSwitch(type, value);
                        },
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddEntityRowExpand extends StatelessWidget {
  final String property;
  final String type;
  final bool value;
  final Widget childWidget;
  final double heightExpand;
  final AddEntityController controller = Get.find();
  AddEntityRowExpand(
      {this.property,
      this.type,
      this.childWidget,
      this.value,
      this.heightExpand});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: value ? heightExpand : 60,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
                      child: Switch(
                        value: value,
                        onChanged: (bool vl) {
                          // controller.isTeleport.value = vl;
                          controller.setSwitch(type, value);
                        },
                      ),
                    )),
              ],
            ),
          ),
          Visibility(
            visible: value,
            child: SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: controller.animation,
                child: childWidget),
          ),
        ],
      ),
    );
  }
}

class AddEntityRowTexture extends StatelessWidget {
  final String property;
  final AddEntityController controller;
  final CreatorItem creatorItem;
  AddEntityRowTexture({this.property, this.controller, this.creatorItem});

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
            Obx(
              () => Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    height: double.infinity,
                    child: controller.skin.isEmpty
                        ? SizedBox()
                        : Image.asset(
                            controller.skin,
                            fit: BoxFit.contain,
                          ),
                  )),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextButton(
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        child: GridView.builder(
                          itemCount: creatorItem.listSkin.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  childAspectRatio: 1 / 1.40,
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            return InkResponse(
                                onTap: () {
                                  controller
                                      .updateSkin(creatorItem.listSkin[index]);
                                  Get.back();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.asset(
                                      creatorItem.listSkin[index],
                                      fit: BoxFit.contain,
                                    )));
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Change'.toUpperCase()),
                ),
              ),
            ),
          ],
        ));
  }
}

class AddEntityRowTextField extends StatelessWidget {
  final String property;
  final TextEditingController textEditingController;
  final bool isChild;
  AddEntityRowTextField(
      {this.property, this.textEditingController, this.isChild});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: Get.width,
        padding:
            !isChild ? EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal: 5),
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
                  onChanged: (value) {
                    textEditingController.value = TextEditingValue(
                        text: value,
                        selection: TextSelection(
                            baseOffset: value.length,
                            extentOffset: value.length));
                  },
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
