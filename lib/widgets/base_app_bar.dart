import 'package:flutter/material.dart';
import 'package:mods_guns/constants/const_drawer.dart';

class BaseAppBar extends StatelessWidget {
  BaseAppBar(this.icon, this.onIconTap, this.text, {this.key});

  final String text;
  final String icon;
  final Function onIconTap;
  final GlobalKey key;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return text != null
        ? Container(
            key: key,
            padding: kPaddingIcon,
            child: FittedBox(
              child: Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: onIconTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //  Image.asset(icon, height: 20, width: 20, color: Colors.white),
                      SizedBox(
                        height: 4,
                      ),
                      Text(text, style: kTextIconAppBar)
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: kPaddingIconText,
            child: GestureDetector(
              onTap: onIconTap,
              child: Icon(Icons.more_vert),
            ),
          );
  }
}
