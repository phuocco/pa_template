import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get_connect/connect.dart' hide Response;
import 'package:mods_guns/models/addons_item.dart';
import 'package:dio/dio.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

const baseUrl = 'https://mcpecenter.com/mine-craft-sv/index.php/MainHome/search_items_by_type?search_keyword=gun&limit_count=0&type_id=1';

class MainProvider extends GetConnect {
  static final MainProvider _singleton = MainProvider._internal();
  factory MainProvider() => _singleton;
  Dio dio = new Dio(
    BaseOptions(
      baseUrl: "https://mcpecenter.com/mine-craft-sv/index.php/MainHome/search_items_v3?search_keyword=gun&limit_count=3",
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    ),
  );
  DioCacheManager _dioCacheManager;
  MainProvider._internal() {
    _dioCacheManager = DioCacheManager(CacheConfig(
      baseUrl: baseUrl,
      // skipDiskCache: true
    ));
    dio.interceptors.add(_dioCacheManager.interceptor);
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: false,
      requestHeader: false,
      error: true,
    ));
  }



  getItem({bool isFetchNewData = false}) async {
    try {
      //404
      Response<String> response = await dio.get<String>(
        baseUrl,
        options: buildCacheOptions(Duration(days: 5),
            maxStale: Duration(days: 10),
            forceRefresh: isFetchNewData),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = addonsItemFromJson(data);
        print("length : " + decodedData.length.toString());

        return decodedData;
      } else {
        return [];
      }
    } on DioError catch (e) {
      print("Error: ${e.message}");
      if (e.message.contains("DatabaseException")) {
        _dioCacheManager.clearAll();
        return getItem();
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return 'timeOut';
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return 'timeOut';
      }
      return [];
    }
  }

}