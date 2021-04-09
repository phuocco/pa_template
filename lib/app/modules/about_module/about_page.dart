import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kBackgroundHorizontalImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLauncherImage,
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'app_name'.tr,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Ultimate Mobile",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSocialContent( facebook, kFacebookIcon,
                          'about_follow_facebook'.tr),
                      buildSocialContent( youtube, kYoutubeIcon,
                          'about_follow_youtube'.tr),
                      buildSocialContent( twitter, kTwitterIcon,
                          'about_follow_twitter'.tr),
                      buildSocialContent( translate, kTranslateIcon,
                          'about_help_translate'.tr),
                      buildSocialContent( email, kEmailIcon,
                          'about_send_email'.tr),
                    ],
                  ),
                ),
              ),
              GetPlatform.isIOS?SizedBox():Container(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black38, width: 2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'about_special_thanks_title'.tr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('about_special_thanks_content'.tr),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
GestureDetector buildSocialContent(
    Function socialFunc, String icon, String text) {
  return GestureDetector(
    onTap: socialFunc,
    child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Image.asset(
              icon,
              width: 48,
              height: 48,
            ),
          ),
          Text(text),
        ],
      ),
    ),
  );
}

facebook() async {
  if (await canLaunch(kFacebookIdUrl)) {
    launch(kFacebookIdUrl);
  } else {
    launch(kFacebookUrl);
  }
}
youtube() {
  launch(kYoutubeUrl);
}
twitter() async {
  if (await canLaunch(kTwitterIdUrl)) {
    launch(kTwitterIdUrl);
  } else {
    launch(kTwitterUrl);
  }
}
translate() {
  final Uri _emailLaunchUri =
  Uri(scheme: 'mailto', path: kEmailSupport, queryParameters: {
    'subject': Uri.encodeFull('about_translate_subject'.tr),
    'body': Uri.encodeFull('about_translate_content'.tr),
  });
  launch(Uri.decodeFull(_emailLaunchUri.toString()));
}
email() {
  final Uri _emailLaunchUri =
  Uri(scheme: 'mailto', path: kEmailSupport, queryParameters: {
    'subject': Uri.encodeFull('about_email_subject'.tr),
    'body': Uri.encodeFull('about_email_content'.tr),
  });
  launch(Uri.decodeFull(_emailLaunchUri.toString()));
}
GestureDetector communityButton(
    {String imagePath, String text, Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
          ),
          Text(text),
        ],
      ),
    ),
  );
}