import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mods_guns/app/data/repository/add_entity_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/creator_module/creator_controller.dart';
import 'package:mods_guns/models/creator.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddEntityController extends GetxController
    with SingleGetTickerProviderMixin {
  final AddEntityRepository repository;
  AddEntityController({this.repository});

  CreatorController creatorController;

  Animation animation;
  AnimationController animationController;

  var isExpand = true.obs;
  var textId = ''.obs;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  var name = ''.obs;
  var power = ''.obs;
  var gravity = ''.obs;
  var damage = ''.obs;
  var shotDelay = ''.obs;

  var explodePower = ''.obs;

//region key
  static const String mEntityKey = "minecraft:entity";
  static const String mItemKey = "minecraft:item";

  static const String mIdentifierKey = "minecraft:identifier";
  static const String mHealthKey = "minecraft:health";
  static const String mExperienceRewardKey = "minecraft:experience_reward";
  static const String mTypeFamilyKey = "minecraft:type_family";
  static const String mMovementKey = "minecraft:movement";
  static const String mScaleKey = "minecraft:scale";
  static const String mInventoryKey = "minecraft:inventory";
  static const String mRideableKey = "minecraft:rideable";

  static const String mBehaviorMeleeAttackKey =
      "minecraft:behavior.melee_attack";
  static const String mBehaviorRangedAttackKey =
      "minecraft:behavior.ranged_attack";
  static const String mBehaviorNearestAttackableTargetKey =
      "minecraft:behavior.nearest_attackable_target";
  static const String mBehaviorAvoidMobTypeKey =
      "minecraft:behavior.avoid_mob_type";
  static const String mBehaviorLeapAtTargetKey =
      "minecraft:behavior.leap_at_target";
  static const String mBehaviorFloatKey = "minecraft:behavior.float";
  static const String mBehaviorPanicKey = "minecraft:behavior.panic";
  static const String mBehaviorTradeWithPlayerKey =
      "minecraft:behavior.trade_with_player";
  static const String mBehaviorFleeSunKey = "minecraft:behavior.flee_sun";
  static const String mBehaviorPlayerRideTamedKey =
      "minecraft:behavior.player_ride_tamed";
  static const String mBehaviorRestrictSunKey =
      "minecraft:behavior.restrict_sun";

  static const String mTeleportKey = "minecraft:teleport";
  static const String mBreathableKey = "minecraft:breathable";
  static const String mBurnsInDaylightKey = "minecraft:burns_in_daylight";
  static const String mHurtWhenWetKey = "minecraft:hurt_when_wet";
  static const String mFireImmuneKey = "minecraft:fire_immune";
  static const String mAttackKey = "minecraft:attack";
  static const String mShooterKey = "minecraft:shooter";
  static const String mCanFlyKey = "minecraft:can_fly";
  static const String mCanClimbKey = "minecraft:can_climb";
  static const String mBreedableKey = "minecraft:breedable";
  static const String mTameableKey = "minecraft:tameable";
  static const String mTransformedKey = "minecraft:transformed";
  static const String mFallDamageKey = "minecraft:fall_damage";
  static const String mBossKey = "minecraft:boss";
  static const String mNameableKey = "minecraft:nameable";

  static const String componentsKey = "components";
  static const String descriptionKey = "description";
  static const String identifierKey = "identifier";
  static const String idKey = "id";
  static const String nameKey = "name";
  static const String eventsKey = "events";
  static const String componentGroupsKey = "component_groups";
  static const String modelKey = "model";

  //endregion

  //region var

  Map componentsDefault;
  var components;
  var events;
  var component_groups;
  var health;
  var exp;
  var family;
  var moveSpeed;
  var size;
  var inventory;
  var canRide;
  var teleport;
  var burnInDaylight;
  var hurtWhenWet;
  var fireImmune;
  var attack;
  var rangedAttack;

  // var _attackType;
  var nearest;
  var avoidMobType;
  var leapAtTarget;
  var waterFloat;
  var panic;
  var breedable;
  var tamable;
  var tranform;
  var fleeSun;
  var playCanRide;
  var restrictSun;
  var fallDamage;
  var boss;
  var nameable;
  var spawnEntity;
  var pickedDrop;
  var pickedTrade;
  var pickedEquip;
  var mob_sound;
  var attackType;
  var melee;
  var waterBreath;
  //endregion

  dynamic model;

  //region bool

  var isCatchFire = false.obs;
  var isExplode = true.obs;
  var isSpawnMob = false.obs;
  var isBaby = false.obs;
  var isTeleport = false.obs;
  var nameTexture = "".obs;
  var nameSkin = "".obs;
  var spawnType = "".obs;
  var isCauseFire = false.obs;

  var isRecipe = false.obs;
  var isKnockBack = true.obs;
  var isExplodeCausesFire = true.obs;

  //endregion

  //region TextEditingController
  var myController = TextEditingController();
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var powerController = TextEditingController(text: "5");
  var gravityController = TextEditingController(text: "0.05");
  var damageController = TextEditingController(text: "5");
  var shotDelayController = TextEditingController(text: "2");
  var explodePowerController = TextEditingController(text: "5");

  //endregion

  //region old

  var textCtrlId = TextEditingController();
  var textCtrlName = TextEditingController();
  var textCtrlPower = TextEditingController();
  var textCtrlGravity = TextEditingController();
  var textCtrlShotDelay = TextEditingController();
  var textCtrlExplodePower = TextEditingController();
  //endregion

  var _skin = ''.obs;
  set skin(value) => _skin.value = value;
  get skin => _skin.value;

  updateSkin(String path) {
    skin = path;
    update();
  }

  setSwitch(String type, bool value) {
    print(!value);
    switch (type) {
      case 'Teleport':
        isTeleport.value = !value;
        break;
      case 'KnockBack':
        isKnockBack.value = !value;
        break;
      case 'CatchFire':
        isCatchFire.value = !value;
        break;
      case 'ExplodeCausesFire':
        isExplodeCausesFire.value = !value;
        break;
      case 'Explode':
        isExplode.value = !value;
        break;
    }
  }

  Future getData(CreatorController creatorController, CreatorItem item) async {
    creatorController.componentsDefault =
        jsonDecode(jsonEncode(creatorController.componentsDefault));
    print('a');
    item.listSkin = await creatorController.getList(item.itemIconsDir);
    skin = item?.itemSkin ?? "";

    if (item.entities == null) {
      item.entities =
          await creatorController.getEntityDynamic(item.itemEntityDir);
    }
    //fixme: id
    var id = "";
    if (item.entities["minecraft:entity"]["components"]
            ["minecraft:identifier"] ==
        null) {
      // id = "${item.entities["minecraft:entity"]["description"]["identifier"]}";
      id = "${item.entities["minecraft:entity"]["description"]["identifier"]}";
      print('a');
    } else {
      id =
          "${item.entities["minecraft:entity"]["components"]["minecraft:identifier"]["id"]}";
    }
    idController.text = id;

    //fixme name
    if (item.baseID == null) {
      item.baseID =
          item.entities["minecraft:entity"]["description"]["identifier"];
      nameController.text = item.itemName;
      print('a');
    } else {
      if (item.data is String) {
        nameController.text = item.data;
      } else {
        if (item.data != null && item.data["name"] != null) {
          nameController.text = item.data["name"];
        }
      }
    }
    //fixme: model
    if (item.dataModel != null) {
      if (item.dataModel['model'] != null) {
        model = item.dataModel['model'];
      }
    }

    update();
  }

  sendBackCreatorItem(CreatorController creatorController, CreatorItem item) {
    //todo get item after edit
    components['minecraft:teleport'] = isTeleport.value ? teleport : null;

    item.entities["minecraft:entity"]["components"] = components;
    print('a');
  }

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutSine,
    );
    animationController.forward();
  }

  @override
  void onReady() {
    super.onReady();
  }

  setTextId(String text) {
    idController.text = text;
    textId.value = text;
    update();
  }

  setExpand(bool value, {String type}) {
    //todo more item, animation
    isExpand.value = !value;
    if (!value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    animationController.dispose();
  }
}
