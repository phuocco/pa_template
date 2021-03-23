import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pa_template/app/modules/history_module/history_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HistoryPage extends GetWidget<HistoryController> {
  final controller = Get.put(HistoryController());
  final box = GetStorage();
  final List<String> list = ['602b08a06a4e101025c98466','602b08a06a4e101025c98466'];
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        TextButton(
          onPressed: () {

            box.write('LIST_RATE', list);
          },
          child: Text('write shared'),
        ),
        TextButton(
          onPressed: () {
            var a = box.read('LIST_HISTORY');
            print(box.read('LIST_HISTORY'));
          },
          child: Text('read shared'),
        ),
        TextButton(
          onPressed: () {

            box.remove('LIST_HISTORY');
          },
          child: Text('remove shared'),
        ),
      ],
    ));
  }
}
