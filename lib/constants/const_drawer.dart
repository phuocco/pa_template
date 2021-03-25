import 'package:flutter/material.dart';

//FIXME: drawer
const kLeadingBox =
    BoxConstraints(minWidth: 20, minHeight: 20, maxWidth: 35, maxHeight: 35);
const kTextStyleIconDrawer = TextStyle(color: Colors.black);
const kColorImageDrawer = Colors.redAccent;

//FIXME: ads
const kBackgroundContainerNativeAds = Colors.black12;
const kBackgroundContainerBannerAds = Colors.black12;

//FIXME: appbar
const kPaddingIconText = EdgeInsets.symmetric(vertical: 8, horizontal: 10);
const kPaddingIcon = EdgeInsets.symmetric(vertical: 4);
const kTextIconAppBar = TextStyle(color: Colors.black);

//FIXME: dialog
const kCancelDialogText = TextStyle(color: Colors.grey);
const kOKDialogText = TextStyle(color: Colors.blue);

//FIXME: saved

final EdgeInsets kPaddingImageSaved =
    EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25);
final EdgeInsets kPaddingAdSection = EdgeInsets.only(bottom: 2.0);
final Color kBackgroundNativeAdColor = Colors.transparent;
final double kHeightSavedContainerButton = 35;
final double kWidthSavedContainerButton = double.maxFinite;
final EdgeInsets kPaddingSavedContainerButton =
    EdgeInsets.symmetric(horizontal: 15, vertical: 5);
final ButtonStyle kButtonStyleSavedContainer = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xff5f6368)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.zero)));
final TextStyle kSavedButtonText = TextStyle(color: Colors.white);

//FIXME : home
final Color kBottomColor = Colors.transparent;