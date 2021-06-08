import 'package:firebase_remote_config/firebase_remote_config.dart';


class RemoteConfigService{
  //More App Android
  static Future<String> getConfigMoreApps() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    String strJson = remoteConfig.getString('more_apps');
    return strJson;
  }
  //More App IOS
  static Future<String> getConfigMoreAppsIOS() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    String strJson = remoteConfig.getString('more_apps_ios');
    return strJson;
  }

  static Future<Map<String, RemoteConfigValue>> getConfigAppVersion() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    Map<String, RemoteConfigValue> mapConfig = remoteConfig.getAll();
    return mapConfig;
  }
  static Future<String> getTimeOpenInterAd() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setDefaults(<String, dynamic>{
      'adRequestInterstitial': '3',
    });
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    String strJson = remoteConfig.getString('adRequestInterstitial');
    return strJson;
  }

}