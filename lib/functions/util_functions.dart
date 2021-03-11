import 'package:get/get.dart';

class UtilFunctions {
  double getHeightBanner(){
    //check isPremium;
    double height = Get.height;

    if(GetPlatform.isAndroid){
      if (Get.height < 420) {
        height = 32;
      } else if (Get.height > 420 && Get.height <= 720) {
        height = 50;
      } else {
        height = 92;
      }
      return height;
    } else {
      return 92;
    }
  }
}