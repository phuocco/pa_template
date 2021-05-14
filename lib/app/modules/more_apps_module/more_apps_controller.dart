import 'package:pa_template/app/data/repository/more_apps_repository.dart';
import 'package:get/get.dart';
import 'package:pa_template/models/more_apps.dart';
import 'package:pa_template/utils/services/remove_config_service.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MoreAppsController extends GetxController{

  final MoreAppsRepository repository;

  MoreAppsController({this.repository});
  final listMoreApp = <MoreApp>[].obs;

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataMoreApp();
  }

  getDataMoreApp() async {
    var jsonMoreApp;
    if (GetPlatform.isAndroid) {
      jsonMoreApp = await RemoteConfigService.getConfigMoreApps();
    } else {
      jsonMoreApp = await RemoteConfigService.getConfigMoreAppsIOS();
    }
    listMoreApp.assignAll(getAppFromJson(jsonMoreApp));
    print('data $jsonMoreApp');
  }

}
