import 'package:pa_template/app/data/provider/detail_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DetailRepository {
  final DetailProvider provider;

  DetailRepository({@required this.provider}) : assert(provider != null);



  downloadFile(String filePath, String urlDownload) => provider.downloadFile(filePath, urlDownload);
}