import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pa_template/controllers/saved_controller.dart';

class SavedScreen extends GetView<SavedController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('App name'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.blue,
            ),

          ),
          Padding(padding: EdgeInsets.only(bottom: 2),child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),),
        ],
      ),
    ));
  }
}
