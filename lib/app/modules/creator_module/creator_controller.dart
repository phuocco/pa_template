import 'dart:math';

import 'package:flutter/services.dart';
import 'package:mods_guns/app/data/repository/creator_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/models/creator.dart';
import 'dart:convert';

import 'package:mods_guns/models/new_creator.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorController extends GetxController{

  final CreatorRepository repository;
  CreatorController({this.repository});

  static CreatorController instance;

  static CreatorController getInstance() {
    if (instance == null) {
      instance = new CreatorController();
    }
    return instance;
  }

  var listDataDefault = <CreatorItem>[].obs;
  var listDataProject = <CreatorItem>[].obs;
  var defaultItem  = ItemDefault().obs;
  Map componentsDefault;
  var itemEdit = CreatorItem().obs;
  var defaultCreator = Creator("aaa").obs;

  var newItemDefault = NewCreatorItem(itemName: "aaa", itemIcon: "bbb", itemSkin: "ccc").obs;
  var newCreatorDefault = NewCreator().obs;


  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newCreatorDefault.value.items = [];
    newCreatorDefault.value.authorName = 'phuoc';
    newCreatorDefault.value.addonName ='gun';
    getCreatorItem();
    initListDefault();
    setDefault();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('closeup lua bang');
  }

  setDefault(){

  }

  add(){
    print('add');
    String name = Random().nextInt(10).toString();
    NewCreatorItem add = NewCreatorItem(
        itemName: name, itemSkin: "skin", itemIcon: "icon");
    newCreatorDefault.value.items.add(add);
    newCreatorDefault.refresh();
    print(newCreatorDefault.value.items.length);
  }

  save(NewCreatorItem newCreatorItem, int index){
    newCreatorDefault.value.items[index] = newCreatorItem;
    newCreatorDefault.refresh();
  }

  Future<dynamic> getEntityDynamic(String src) async {
    try {
      String jsonString = await rootBundle.loadString("assets/$src");
      return json.decode(jsonString);
    } catch (e) {
      print(e);
      return null;
    }
  }

  getCreatorItem() async {
    try {
      String listData = await rootBundle.loadString("assets/mcpe/json/item_manifest.json");
      var componentsData =
      await rootBundle.loadString("assets/mcpe/json/component.json");
      List responseJson = json.decode(listData);
      Map components = json.decode(componentsData);
      setDataDefault(responseJson.map((m) => new CreatorItem.fromJson(m)).toList(),
          components);
    } catch (e) {
      print(e);
    }
  }

  setDataDefault(list, componentsData) {
    listDataDefault.assignAll(list);
    componentsDefault = componentsData;
    print('a');
  }
  initListDefault() {
    List list;
    if (listDataProject.isNotEmpty) {
      listDataDefault.forEach((e1) {
        ItemDefault itemDefault = ItemDefault();
        CreatorItem item = listDataProject.firstWhere(
                (item) => item.itemName == e1.itemName,
            orElse: () => null);
        if (item != null) {
          itemDefault.item = item;
          itemDefault.isChangeData = true;
        } else {
          itemDefault.item = e1;
        }
        list.add(itemDefault);
      });
    }
  }

}
