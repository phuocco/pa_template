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

  //region bool
  var isGravity = true.obs;
  var isShooter = false.obs;
  var isEditModel = false.obs;
  var isSpawnRules = false.obs;
  var isPickSounds = false.obs;
  var isFollowOwner = false.obs;
  var isBoss = false.obs;
  var isNameable = false.obs;
  var isInventory = false.obs;
  var isNewMob = false.obs;
  var isPlayerRide = false.obs;
  var isTeleport = false.obs;
  var isBreath = false.obs;
  var isDaylight = false.obs;
  var isFly = false.obs;
  var isClimb = false.obs;
  var isWet = false.obs;
  var isImmune = false.obs;
  var isTrade = false.obs;
  var isSpawnEntity = false.obs;
  var isDamage = false.obs;
  var isMelee = false.obs;
  var isRanged = false.obs;
  var isNearest = false.obs;
  var isAvoidMob = false.obs;
  var isLeap = false.obs;
  var isWaterFloat = false.obs;
  var isPanic = false.obs;
  var isBreedAble = false.obs;
  var isTamable = false.obs;
  var isTransform = false.obs;
  var isFleeSun = false.obs;
  var isRideTame = false.obs;
  var isRestrictSun = false.obs;
  var isRestrictFall = false.obs;
  var isShouldDarkenSky = false.obs;
  var isAlwaysShow = false.obs;
  var isAllowNameTagRenaming = false.obs;
  var isBubble = false.obs;
  var isTarget = false.obs;
  var isMultipleTexture = false.obs;
  var isBlockFilter = false.obs;

  //endregion

  //region TextEditingController
  var flyController = TextEditingController();
  var myController = TextEditingController();
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var healthController = TextEditingController();
  var expController = TextEditingController();
  var moveController = TextEditingController();
  var sizeController = TextEditingController();
  var inventorySizeController = TextEditingController();
  var hudController = TextEditingController();
  var weightController = TextEditingController(text: "100");
  var controllerAttackType = TextEditingController();
  var controllerBaby = TextEditingController();
  var leapController = TextEditingController();
  var radiusController = TextEditingController();
  var speedRangedController = TextEditingController();
  var radiusRangedController = TextEditingController();
  var shotsRangedController = TextEditingController();
  var intervalRangedController = TextEditingController();
  var valueDamageController = TextEditingController();
  var speedMeleeController = TextEditingController();
  var positionXController = TextEditingController();
  var positionYController = TextEditingController();
  var positionZController = TextEditingController();
  var randomTimeController = TextEditingController();
  var distanceController = TextEditingController();
  var timesController = TextEditingController();
  var limitSpawnController = TextEditingController(text: "2");
  var cooldownController = TextEditingController(text: "1");

  //endregion

  //region old
  // var isTeleport = false.obs;
  var isKnockBack = true.obs;
  var isCatchFire = true.obs;
  var isExplodeCausesFire = true.obs;

  var textCtrlId = TextEditingController();
  var textCtrlName = TextEditingController();
  var textCtrlPower = TextEditingController();
  var textCtrlGravity = TextEditingController();
  var textCtrlShotDelay = TextEditingController();
  var textCtrlExplodePower = TextEditingController();
  //endregion

  String skin = "";

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
    //todo: id
    var id = "";
    if (item.entities["minecraft:item"]["components"]
            ["minecraft:identifier"] ==
        null) {
      // id = "${item.entities["minecraft:entity"]["description"]["identifier"]}";
      id = "${item.entities["minecraft:item"]["description"]["identifier"]}";
      print('a');
    } else {
      id =
          "${item.entities["minecraft:entity"]["components"]["minecraft:identifier"]["id"]}";
    }
    idController.text = id;



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
