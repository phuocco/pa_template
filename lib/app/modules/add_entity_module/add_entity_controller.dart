import 'dart:convert';
import 'dart:io';

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

  var definition_event = {
    "affectProjectile": true,
    "eventTrigger": {"event": "minecraft:explode", "target": "self"}
  };
  var entities;
  var collision_box;
  var projectile;
  Map on_hit;
  dynamic modelBullet;
  var explode;
  var spawn_mob;
  String keyOnHit = "on_hit";
  File imageCustom;

  //region bool
  var name = ''.obs;
  var power = 0.0.obs;
  var gravity = 0.0.obs;
  var damage = ''.obs;
  var shotDelay = ''.obs;
  var explodePower = ''.obs;

  var isCatchFire = false.obs;
  var isExplode = false.obs;
  var isSpawnMob = false.obs;
  var isBaby = false.obs;
  var isTeleport = false.obs;
  var nameTexture = "".obs;
  var nameSkin = "".obs;
  var spawnType = "".obs;
  var isCauseFire = false.obs;

  var isRecipe = false.obs;
  var isKnockBack = false.obs;
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

  CreatorItem item;
  Future getData(
      CreatorController creatorController, CreatorItem creatorItem) async {
    creatorController.componentsDefault =
        jsonDecode(jsonEncode(creatorController.componentsDefault));

    item = creatorItem;

    if (item.entities == null) {
      item.entities =
          await creatorController.getEntityDynamic(item.itemEntityDir);
    }
    entities = item.entities;

    item.listSkin = await creatorController.getList(item.itemIconsDir);

    nameTexture.value = (item?.itemTexture ?? "");
    if (nameTexture.value.startsWith("mcpe/projectile/icons")) {
      nameTexture.value = "";
      nameController.text = nameTexture.value;
    }

    var arrName = item.itemName.split("_");
    if (arrName.length > 2) {
      nameController.text = arrName[1];
    }

    nameSkin.value = item?.itemSkin ?? "";
    print(item.toJson());

    components = item.entities["minecraft:entity"]["components"];
    collision_box = components['minecraft:collision_box'];
    projectile = components['minecraft:projectile'];

    if (item.entities["format_version"] == "1.10.0") {
      keyOnHit = "onHit";
    }

    power.value = components['minecraft:projectile']["power"];
    powerController.text = power.toString();

    gravity.value = components['minecraft:projectile']["gravity"];
    gravityController.text = gravity.value.toString();

    projectile = components['minecraft:projectile'];

    if (item.entities["format_version"] == "1.10.0") {
      keyOnHit = "onHit";
    }

    on_hit = components['minecraft:projectile'][keyOnHit];

    explode =
        item.entities["minecraft:entity"]["components"]["minecraft:explode"];

    if (!isExplode.value) {
      explode = item.entities["minecraft:entity"]['component_groups']
          ['minecraft:exploding']['minecraft:explode'];
      print('a');
    }
    isExplode.value = explode != null;
    print('a');
    explodePowerController.text = explode["power"].toString();

    if (explode["causesFire"] != null) {
      isCauseFire.value = explode["causesFire"];
    } else if (explode["causes_fire"] != null) {
      isCauseFire.value = explode["causes_fire"];
    } else if (explode["catchFire"] != null) {
      isCauseFire.value = explode["catchFire"];
    }

    if (item.dataModel != null) {
      if (item.dataModel['model'] != null) {
        model = item.dataModel['model'];
      }
    }

    if (on_hit != null) {
      print(on_hit);
      isTeleport.value = on_hit['teleport_owner'] != null;
    }

    if (item.dataModelBullet != null) {
      if (item.dataModelBullet['model'] != null) {
        modelBullet = item.dataModelBullet['model'];

        // if ()

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
