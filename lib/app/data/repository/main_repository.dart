import 'package:pa_template/app/data/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MainRepository {
  final MainProvider provider;

  MainRepository({@required this.provider}) : assert(provider != null);


  getItem({bool isFetchNewData = false}) => provider.getItem(isFetchNewData: isFetchNewData);



}