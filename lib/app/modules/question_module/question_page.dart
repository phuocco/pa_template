import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mods_guns/app/modules/question_module/question_controller.dart';
import 'package:mods_guns/app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionPage extends GetWidget<QuestionController> {
  @override
  Widget build(BuildContext context) {
    String contactString = 'faq_a5'.tr;
    int indexYoutube = contactString.indexOf("UltimateCraft");
    int indexFanPage = contactString.indexOf("Ultimate Mobile");
    int indexGroup = contactString.indexOf("Addons Maker Community");
    int indexEmail = contactString.indexOf("contact@pamobile.co");
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*faqContainer('faq_q1'.tr,'faq_a1'.tr),*/
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('faq_q2'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Text('faq_a2'.tr)),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Image(
                                image: AssetImage("assets/images/faq2.png"),
                              )),
                          Divider(height: 1, color: Colors.black),
                        ]),
                  ),
                  faqContainer('faq_q3'.tr,'faq_a3'.tr),
                  faqContainer('faq_q4'.tr,'faq_a4'.tr),
                  faqContactContainer('faq_q5'.tr, RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            text: contactString.substring(0, indexYoutube)),
                        TextSpan(
                            text: contactString.substring(indexYoutube,
                                indexYoutube + ("UltimateCraft").length),
                            style: TextStyle(
                                color: Colors.blue
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(kYoutubeUrl);
                              }),
                        TextSpan(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            text: contactString.substring(
                                indexYoutube + ("UltimateCraft").length,
                                indexFanPage)),
                        TextSpan(
                            text: contactString.substring(indexFanPage,
                                indexFanPage + ("Ultimate Mobile").length),
                            style: TextStyle(
                                color: Colors.blue
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(kFacebookIdUrl)) {
                                  launch(kFacebookIdUrl);
                                } else {
                                  launch(kFacebookUrl);
                                }
                              }),
                        TextSpan(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            text: contactString.substring(
                                indexFanPage + ("Ultimate Mobile").length,
                                indexGroup)),
                        TextSpan(
                            text: contactString.substring(indexGroup,
                                indexGroup +
                                    ("Addons Maker Community").length),
                            style: TextStyle(
                                color: Colors.blue
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(kFacebookGroupId)) {
                                  launch(kFacebookGroupId);
                                } else {
                                  launch(kFacebookGroupUrl);
                                }
                              }),
                        TextSpan(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            text: contactString.substring(indexGroup +
                                ("Addons Maker Community").length,
                                indexEmail)),
                        TextSpan(
                            text: contactString.substring(indexEmail,
                                indexEmail + ("contact@pamobile.co").length),
                            style: TextStyle(
                                color: Colors.blue
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                final Uri _emailLaunchUri =
                                Uri(scheme: 'mailto',
                                    path: kEmailContact,
                                    queryParameters: {
                                      'subject': Uri.encodeFull('about_email_subject'.tr),
                                      'body': Uri.encodeFull('about_email_content'.tr),
                                    });
                                launch(Uri.decodeFull(
                                    _emailLaunchUri.toString()));
                              }

                        ),

                      ],
                    ),
                  )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: ClipOval(
                    child: Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(16),
                        color: Colors.blue,
                        child: Image.asset(
                          "assets/images/icons/ic_fab_question.png",
                        )),
                  ),
                  onTap: () {
                    final Uri _emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: kEmailSupport,
                        queryParameters: {
                          'subject':
                              Uri.encodeFull('question_email_subject'.tr),
                          'body': Uri.encodeFull('about_email_content'.tr),
                        });

                    print(_emailLaunchUri.toString());
                    launch(Uri.decodeFull(_emailLaunchUri.toString()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
 Widget faqContainer(String question, String answer){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5, vertical: 8),
              child: Text(
                answer,
                style: TextStyle(height: 1.25),
              ),
            ),
            Divider(height: 2, color: Colors.black),
          ]),
    );
  }
  Widget faqContactContainer(String question, Widget answer){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: answer,
        ),
        Divider(height: 2, color: Colors.black),
      ]),
    );
  }
}
