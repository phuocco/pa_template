import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/modules/card_module/view/card_view.dart';

import 'modules/card_module/view/card_view.dart';
import 'modules/gallery_module/view/gallery_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
           TextButton(onPressed: () => Get.to(() => CardView()), child: Text('card')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => GalleryView()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
