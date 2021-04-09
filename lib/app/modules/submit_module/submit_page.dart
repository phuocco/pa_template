import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';
class SubmitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        height: double.maxFinite,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('submit_ui_label'.tr),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(child: Image.asset("assets/images/tutorial_image/mods/submit_guide.jpg")),
              ),
              FlatButton(color: Colors.lightBlueAccent,onPressed: (){
                final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: kEmailSupport,
                    queryParameters: {
                      'subject': Uri.encodeFull('submit_email_subject'.tr),
                      'body': Uri.encodeFull('submit_email_content'.tr),
                    }
                );
                print(_emailLaunchUri.toString());
                launch(Uri.decodeFull(_emailLaunchUri.toString()));
              }, child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: double.maxFinite,
                child: Center(
                  child: Text('submit_button_submit'.tr, style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ))
            ],
          ),
        )
    );
  }
}
