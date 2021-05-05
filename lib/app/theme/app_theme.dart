import 'package:flutter/material.dart';

import 'app_colors.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
final ButtonStyle kDownloadButton  = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(
      Colors.transparent),
  backgroundColor: MaterialStateProperty.all<Color>(
      Colors.transparent),
);