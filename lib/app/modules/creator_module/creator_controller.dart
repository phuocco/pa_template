import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:mods_guns/app/modules/detail_module/detail_controller.dart';
import 'package:mods_guns/models/behavior_manifest.dart';
import 'package:mods_guns/models/item_texture.dart';
import 'package:mods_guns/models/resource_manifest.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mods_guns/app/data/repository/creator_repository.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:mods_guns/models/creator.dart';
import 'dart:convert';

import 'package:mods_guns/models/new_creator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreatorController extends GetxController {
  final CreatorRepository repository;
  CreatorController({this.repository});

  static CreatorController instance;

  static CreatorController getInstance() {
    if (instance == null) {
      instance = new CreatorController();
    }
    return instance;
  }

  String functionStr = "";
  Map resource;
  var sound_definitions = {};
  var sounds = {
    "entity_sounds": {"entities": {}}
  };
  var biome_client = {"biomes": {}};
  Map randomWeight;
  Map terrain;
  int numArmor = -1;
  String addStr = "";
  Map player;
  List remove_effects;

  var listSelectEntity = <CreatorItem>[].obs;
  var listDataProject = <CreatorItem>[].obs;
  Map componentsDefault;
  File image;
  var itemEdit = CreatorItem().obs;
  var defaultCreator = Creator("phuoc").obs;

  ItemTexture item_texture;

  var _pathAddon2 = ''.obs;
  set pathAddon2(value) => _pathAddon2.value = value;
  get pathAddon2 => _pathAddon2.value;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  initPath() async {
    final directory = await getExternalStorageDirectory();
    pathAddon2 = directory.path + "/";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initPath();
    defaultCreator.value.items = [];
    getCreatorItem();
    // initListDefault();
    setDefault();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  setDefault() {}

  var listItem = <CreatorItem>[].obs;

  add() {
    print('add');
    String name = Random().nextInt(10).toString();
    CreatorItem add = CreatorItem();
    defaultCreator.value.items.add(add);
    print('a');
    defaultCreator.refresh();
  }

  save(CreatorItem creatorItem) {
    CreatorItem add = new CreatorItem();
    add = creatorItem;
    listDataProject.add(creatorItem);
    // defaultCreator.value.items.assignAll(listDataProject);
    print('a');
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
      String listData =
          await rootBundle.loadString("assets/mcpe/json/item_manifest.json");
      var componentsData =
          await rootBundle.loadString("assets/mcpe/json/component.json");
      List responseJson = json.decode(listData);
      Map components = json.decode(componentsData);
      setDataDefault(
          responseJson.map((m) => new CreatorItem.fromJson(m)).toList(),
          components);
    } catch (e) {
      print(e);
    }
  }

  Future<List> getList(String dir) async {
    if (dir.endsWith("/zombie")) {
      dir = dir + "/";
    }
    return manifestMap.keys
        .where((String key) => key.contains("assets/$dir"))
        .where((key) => !key.contains("DS_Store"))
        .toList();
  }

  setDataDefault(list, componentsData) {
    listSelectEntity.assignAll(list);
    componentsDefault = componentsData;
    print('a');
  }

  initListDefault() {
    List list;
    if (listDataProject.isNotEmpty) {
      listSelectEntity.forEach((e1) {
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

  var nameAddonController = TextEditingController();
  var nameAuthorController = TextEditingController();
  var descriptionController = TextEditingController();

  exportAddon() async {
    defaultCreator.value.items = listDataProject;
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    PermissionStatus permission = statuses[Permission.storage];
    if (permission == PermissionStatus.granted) {
      Map data = await Get.dialog(AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameAddonController..text = "a",
            ),
            TextField(
              controller: nameAuthorController..text = 'b',
            ),
            TextField(
              controller: descriptionController..text = 'c',
            ),
            InkResponse(
              onTap: chooseImage,
              child: Container(
                width: 110,
                height: 110,
                child: image == null
                    ? Image.asset(kAboutIcon,
                        fit: BoxFit.fill)
                    : Image.file(
                        image,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel')),
          TextButton(onPressed: () => export(), child: Text('export')),
        ],
      ));
      if (data != null) {
        print(data);
        Creator file = await exportAddonToFile(
          data['nameAddon'],
          data['author'],
          data['description'],
          data['image'],
        );
        if (file != null) {
          /* Đóng loading */
          Get.back();
          /* Show dialog Success */
          Get.dialog(Dialog(
            child: TextButton(onPressed: () {
              DetailController().importToMinecraft(file.addonUrl);
            }, child: Text('Import to MC')),
          ));
        }
      }
    }
  }
  final _picker = ImagePicker();

  Future chooseImage() async {
    final pickedFile = await _picker.getImage(
        source: ImageSource.gallery, maxWidth: 256, maxHeight: 256);
    File newFile = File(pickedFile.path);
    if (pickedFile != null) {
      image = newFile;
    }
  }

  Future<Creator> exportAddonToFile(String nameAddOn, String nameAuthor,
      String description, File image) async {
    var addonUrl = pathAddon2 +
        nameAddOn +
        "_${DateTime.now().millisecondsSinceEpoch}.mcaddon";

    Creator project = saveAddon(
        nameAddOn, nameAuthor, description, image?.path ?? null,
        addonUrl: addonUrl);
    List<CreatorItem> listProjectItems = project.items;

    if (Platform.isAndroid) {
      await Directory(pathAddon2)
          .create(recursive: true)
          .then((Directory dir) => {
                new File((dir.path + "/.nomedia").replaceAll("//.", "/."))
                    .createSync(recursive: true)
              });
    } else {
      var file = File(pathAddon2 + "/.nomedia");
      if (file.existsSync()) {
        file.deleteSync();
      }
    }

    await copyAssetFolder("addon", pathAddon2 + nameAddOn, nameAddOn);

    String behaviorPack = pathAddon2 +
        nameAddOn +
        '/' +
        nameAddOn +
        '_behavior_pack/pack_icon.png';
    String resourcePack = pathAddon2 +
        nameAddOn +
        '/' +
        nameAddOn +
        '_resource_pack/pack_icon.png';
    if (image != null) {
      copyCustomFile(image.path, behaviorPack);
      copyCustomFile(image.path, resourcePack);
    }
    project.mImageUrl = behaviorPack;

    var outEnus = pathAddon2 +
        nameAddOn +
        "/" +
        nameAddOn +
        "_resource_pack/texts/en_US.lang";
    String en_us = await readFileString(outEnus);
    //endregion

    functionStr = "";

    resource = {};
    sound_definitions = {};
    sounds = {
      "entity_sounds": {"entities": {}}
    };
    biome_client = {"biomes": {}};
    randomWeight = {
      "format_version": "1.13.0",
      "minecraft:weighted_random_feature": {
        "description": {"identifier": "pa:random_tree_feature"},
        "features": []
      }
    };
    terrain = {
      "resource_pack_name": "vanilla",
      "texture_name": "atlas.terrain",
      "padding": 8,
      "num_mip_levels": 4,
      "texture_data": {}
    };

    bool needPlayer = false;
    bool hasBlock = false;
    bool hasTree = false;
    numArmor = -1;
    addStr = "";
    print('item_texture_str $pathAddon2');
    var item_texttures_path = pathAddon2 +
        nameAddOn +
        "/" +
        nameAddOn +
        "_resource_pack/textures/item_texture.json";
    print('item_texture_str $item_texttures_path');
    String item_texture_str = await readFileString(item_texttures_path);
    print('item_texture_str $item_texture_str');

    item_texture = ItemTexture.fromJson(json.decode(item_texture_str));

    player = await getEntityDynamic("mcpe/json/player.json");
    remove_effects = player["minecraft:entity"]["component_groups"]
            ["pamobile:respawn"]["minecraft:spell_effects"]["remove_effects"]
        .toList();
    var futures = List<Future>();
    for (int i = 0; i < listProjectItems.length; i++) {
      if (listProjectItems[i].itemName.toLowerCase().contains("weapon_") ||
          listProjectItems[i].itemName.toLowerCase().startsWith("armor_")) {
        if (listProjectItems[i].effects != null) {
          var effect = listProjectItems[i].effects.map((e) => e["name"]);
          remove_effects.addAll(effect);
        }
      }
    }
    remove_effects = remove_effects.toSet().toList();
    player["minecraft:entity"]["component_groups"]["pamobile:respawn"]
        ["minecraft:spell_effects"]["remove_effects"] = remove_effects;

    for (int i = 0; i < listProjectItems.length; i++) {
      var item = listProjectItems[i];
      needPlayer = true;
      var future = versionProjectile(nameAddOn, listProjectItems[i]);
      futures.add(future);
    }

    String behavior = pathAddon2 + "${nameAddOn}/${nameAddOn}_behavior_pack/";
    String resources = pathAddon2 + "${nameAddOn}/${nameAddOn}_resource_pack/";

    var resUUID = Uuid().v4();
    ResourceManifest resourceManifest = await loadRManifest();
    resourceManifest.header.name = nameAddOn;
    resourceManifest.header.description = "$description by $nameAuthor";
    resourceManifest.header.uuid = resUUID;

    resourceManifest.modules[0].description = "$description by $nameAuthor";
    resourceManifest.modules[0].uuid = Uuid().v4();

    BehaviorManifest behaviorManifest = await loadBManifest();

    behaviorManifest.dependencies = null;
    behaviorManifest.header.name = nameAddOn;
    behaviorManifest.header.description = "$description by $nameAuthor";
    behaviorManifest.header.uuid = Uuid().v4();
    behaviorManifest.modules[0].description = "$description by $nameAuthor";
    behaviorManifest.modules[0].uuid = Uuid().v4();

    JsonEncoder jencoder = JsonEncoder.withIndent('  ');
    await getCreateJsonFile(
        behavior, "manifest", jencoder.convert(behaviorManifest.toJson()));
    await getCreateJsonFile(
        resources, "manifest", jencoder.convert(resourceManifest.toJson()));

    Future summit() async {
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      await Future.wait(futures);

      await writeStringFile(item_texttures_path, encoder.convert(item_texture));
      var sound_definitions_path = pathAddon2 +
          nameAddOn +
          "/" +
          nameAddOn +
          "_resource_pack/sounds/sound_definitions.json";
      await writeStringFile(
          sound_definitions_path, encoder.convert(sound_definitions));

      var sounds_path = pathAddon2 +
          nameAddOn +
          "/" +
          nameAddOn +
          "_resource_pack/sounds.json";
      await writeStringFile(sounds_path, encoder.convert(sounds));

      if (needPlayer) {
        String entitiesPath =
            pathAddon2 + "$nameAddOn/$nameAddOn" "_behavior_pack/entities";
        await getCreateJsonFile(
            entitiesPath, "player", encoder.convert(player));
      }

      if (hasBlock) {
        var block_r_path = pathAddon2 +
            nameAddOn +
            "/" +
            nameAddOn +
            "_resource_pack/blocks.json";
        var terrain_path = pathAddon2 +
            nameAddOn +
            "/" +
            nameAddOn +
            "_resource_pack/textures/terrain_texture.json";
        resource['format_version'] = [1, 1, 0];
        await writeStringFile(block_r_path, encoder.convert(resource));
        await writeStringFile(terrain_path, encoder.convert(terrain));
      }

      if (addStr != "") {
        var content = addStr + en_us;
        await writeStringFile(outEnus, content);
      }

      if (functionStr != "") {
        var item_function_path = pathAddon2 +
            nameAddOn +
            "/" +
            nameAddOn +
            "_behavior_pack/functions/${nameAddOn.replaceAll(" ", "_")}.mcfunction";
        await writeStringFile(item_function_path, functionStr);
      }

      var outPath = pathAddon2 +
          nameAddOn +
          "/" +
          nameAddOn +
          "_resource_pack/biomes_client.json";

      await writeStringFile(outPath, encoder.convert(biome_client));

      resourceManifest.header.name = nameAddOn;
      resourceManifest.header.description = "$description by $nameAuthor";
      if (resourceManifest.header.uuid == "") {
        resourceManifest.header.uuid = Uuid().v4();
      }

      resourceManifest.modules[0].description = "$description by $nameAuthor";
      if (resourceManifest.modules[0].uuid == "") {
        resourceManifest.modules[0].uuid = Uuid().v4();
      }

      behaviorManifest.dependencies = null;
      behaviorManifest.header.name = nameAddOn;
      behaviorManifest.header.description = "$description by $nameAuthor";
      if (behaviorManifest.header.uuid == "") {
        behaviorManifest.header.uuid = Uuid().v4();
      }

      behaviorManifest.modules[0].description = "$description by $nameAuthor";
      if (behaviorManifest.modules[0].uuid == "") {
        behaviorManifest.modules[0].uuid = Uuid().v4();
      }

      var bhvp = behaviorManifest.toJson();
      var rsp = resourceManifest.toJson();
      for (var entry in bhvp.entries.toList()) {
        if (entry.value == null) {
          bhvp.remove(entry.key);
        }
      }
      for (var entry in rsp.entries.toList()) {
        if (entry.value == null) {
          rsp.remove(entry.key);
        }
      }
      await getCreateJsonFile(behavior, "manifest", encoder.convert(bhvp));
      await getCreateJsonFile(resources, "manifest", encoder.convert(rsp));
      await writeStringFile(
          pathAddon2 + "${nameAddOn}/.data", jsonEncode(project));
    }

    if (kReleaseMode) {
      await summit().catchError((e) {
        print(e);
      });
    } else {
      await summit();
    }
    await Future.delayed(Duration(seconds: 2));
    var encoder = ZipFileEncoder();
    // Manually create a zip of a directory and individual files.
    encoder.create(addonUrl);
    encoder.addDirectory(Directory(resources));
    encoder.addDirectory(Directory(behavior));
    // encoder.addFile(File(pathAddon2 + "${nameAddOn}/.data"));
    encoder.close();
    File file = File(encoder.zip_path);
    await Future.delayed(Duration(seconds: 2));
    return project;
  }

  Future loadRManifest() async {
    String jsonString =
        await rootBundle.loadString('assets/addon/server/manifest.json');
    final jsonResponse = json.decode(jsonString);
    return ResourceManifest.fromJson(jsonResponse);
  }

  Future loadBManifest() async {
    String jsonString =
        await rootBundle.loadString('assets/addon/client/manifest.json');
    final jsonResponse = json.decode(jsonString);
    return BehaviorManifest.fromJson(jsonResponse);
  }

  Future getCreateJsonFile(String path, String name, String data) async {
    File file = File("${path}/${name}.json");
    if (file.existsSync()) {
      file.deleteSync();
    }
    await writeStringFile("${path}/${name}.json", data);
  }

  Future<File> writeStringFile(String output, String content) async {
    var file = File(output);
    var dir = Directory(p.dirname(output));
    if (!dir.existsSync()) {
      await Directory(p.dirname(output)).create(recursive: true);
    }
    if (!file.existsSync()) {
      await file.create();
    }
    // Write the file
    return file.writeAsString('$content');
  }

  Future versionProjectile(String nameAddOn, CreatorItem item) async {
    String nameMob = p.basenameWithoutExtension(item.itemEntityDir);
    String entities =
        pathAddon2 + "$nameAddOn/$nameAddOn" "_behavior_pack/entities";
    getCreateJsonFile(
        entities, nameMob.toLowerCase(), json.encode(item.entities));

    String nameTexture = item.itemTexture.toString();

    var futures = List<Future>();
    if (nameTexture == "") {
    } else {
      if (item.itemEntityTexture != null) {
        for (var out in item.itemEntityTexture) {
          String outPath =
              "${pathAddon2}${nameAddOn}/${nameAddOn}_resource_pack/textures/$out";
          var future;
          if (!out.toString().contains("entity/")) {
            if (nameTexture.contains('assets/projectile')) {
              await Directory(p.dirname(outPath)).create(recursive: true);
              future = copyAssetFile(nameTexture, outPath);
            } else {
              future = copyCustomFile(nameTexture, outPath);
            }
            item.itemTexture = outPath;
            futures.add(future);
          }
        }
      }
    }
    String nameSkin = item.itemSkin.toString();
    print("skin: ${nameSkin}");
    if (nameSkin == "") {
    } else {
      if (item.itemEntityTexture != null) {
        for (var out in item.itemEntityTexture) {
          String outPath =
              "${pathAddon2}${nameAddOn}/${nameAddOn}_resource_pack/textures/$out";
          var future;
          if (out.toString().contains("entity/")) {
            if (nameSkin.contains('assets/projectile')) {
              await Directory(p.dirname(outPath)).create(recursive: true);
              future = copyAssetFile(nameSkin, outPath);
            } else {
              future = copyCustomFile(nameSkin, outPath);
            }
            item.itemSkin = outPath;
            futures.add(future);
          }
        }
      }
    }

    await Future.wait(futures);
  }

  Future<String> readFileString(String path) async {
    try {
      final file = File(path);
      print('item_texture_str ${file.toString()}');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        print('item_texture_str dang tao');
      }
      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      print('item_texture_str gap loi');
      print(e);
      return "";
    }
  }

  Future<bool> copyCustomFile(String dataPath, String toPath) async {
    if (Platform.isIOS) {
      if (dataPath.contains("/Documents/images/") &&
          !File(dataPath).existsSync()) {
        dataPath = pathAddon2 + "${dataPath.split("/Documents/").last}";
      }
    }
    var data = await readFile(dataPath);
    File file = File(toPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
    try {
      await writeUint8(toPath, data);
    } catch (exception) {
      if (!kReleaseMode) {
        print("copyCustomFile $dataPath $toPath Error: $exception ");
      }
    }
    return true;
  }

  Future<File> writeUint8(String output, Uint8List data) async {
    var file = File(output);
    var dir = Directory(p.dirname(output));
    if (!dir.existsSync()) {
      await Directory(p.dirname(output)).create(recursive: true);
    }
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    // Write the file
    //final buffer = data.buffer;
    return file.writeAsBytes(data);
  }

  Future<Uint8List> readFile(String path) async {
    try {
      final file = File(path);
      if (file.existsSync()) {
        return await file.readAsBytes();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<File> writeByteDat(String output, ByteData data) async {
    var file = File(output);
    var dir = Directory(p.dirname(output));
    if (!dir.existsSync()) {
      await Directory(p.dirname(output)).create(recursive: true);
    }
    if (!file.existsSync()) {
      await file.create();
    }
    // Write the file
    final buffer = data.buffer;
    return file.writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future copyAssetFile(String input, String output) async {
    if (!input.startsWith("assets/")) {
      input = "assets/${input}";
    }
    try {
      var data = await rootBundle.load(input);
      File file = File(output);
      if (file.existsSync()) {
        file.deleteSync();
      }
      await writeByteDat(output, data);
    } catch (exception) {
      if (!kReleaseMode) {
        print("copyAssetFile $input $output Error: $exception ");
      }
    }
    return true;
  }

  Future<bool> copyAssetFolder(
      String fromAssetPath, String toPath, String addonName) async {
    var list = await getList(fromAssetPath);
    for (String dir in list) {
      if (!dir.contains(".DS_Store")) {
        if (dir.contains("client/")) {
          var childDir = dir.split("client/");
          if (childDir.length > 0) {
            // print("client123 $childDir");
            await copyAssetFile(dir,
                toPath + '/' + addonName + '_resource_pack/' + childDir[1]);
          } else {
//            print(dir);
          }
        } else {
          var childDir = dir.split("server/");
          if (childDir.length > 0) {
//            print(childDir);
            await copyAssetFile(dir,
                toPath + '/' + addonName + '_behavior_pack/' + childDir[1]);
          } else {
//            print(dir);
          }
        }
      }
    }

    return true;
  }

  Creator saveAddon(
      String nameAddOn, String nameAuthor, String description, String mImageUrl,
      {String addonUrl}) {
    List<CreatorItem> listItems =
        parseProjectItems(jsonEncode(listDataProject));
    Creator project = Creator(Uuid().v4(),
        addonName: nameAddOn,
        authorName: nameAuthor,
        description: description,
        mImageUrl: mImageUrl,
        addonUrl: addonUrl,
        items: listItems);
    // SharedPreferencesFunc().saveHistory(project);
    return project;
  }

  export() async {
    String nameAddon = nameAddonController.text;
    String author = nameAuthorController.text;
    String description = descriptionController.text;

    Map data = {
      'nameAddon': nameAddon,
      'author': author,
      'description': description,
      'image': image,
    };
    Get.back(result: data);
  }

  writeFileText() async {
    final directory = await getExternalStorageDirectory();
    String path = directory.path;
    path =
        '/storage/emulated/0/Android/data/co.pamobile.mcpe.mods.guns/files/a/a_resource_pack/texts';
    File file = File(path + "/en_US.lang");
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsString('aaaaaaaaaaaaaaa');
  }

  readImage() async {
    final file = File(imageAddon);
    final contents = await file.readAsString();
    print('a');
  }
}
