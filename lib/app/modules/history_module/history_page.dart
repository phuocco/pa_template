import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/modules/history_module/history_controller.dart';
import 'package:pa_template/app/modules/saved_module/saved_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryPage extends StatelessWidget {
  final controller = Get.put(HistoryController());
  final savedController = Get.put(SavedController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<HistoryController>(
        builder: (_) {
          if (_.listHistory.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemCount: _.listHistory.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 7 / 14,
                crossAxisSpacing: 20,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: Image.file(
                            File(controller.listHistory[index].card.cardImg)),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(Icons.cloud_upload), onPressed: (){
                                savedController.uploadCard(controller.listHistory[index], index);
                          }),
                          IconButton(
                              icon: Icon(Icons.delete), onPressed: null),
                        ],
                      )),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
