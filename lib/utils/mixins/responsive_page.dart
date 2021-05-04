
import 'package:flutter/material.dart';
import 'package:get/get.dart';
abstract class ResponsivePage {
  Widget buildTablet(BuildContext context);
  Widget buildPhone(BuildContext context);
  Widget buildUi(BuildContext context){
    if(context.isTablet){
      return buildTablet(context);
    }
    return buildPhone(context);
  }
}