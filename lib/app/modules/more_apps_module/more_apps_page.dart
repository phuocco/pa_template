import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:pa_template/app/data/provider/home_provider.dart';
import 'package:pa_template/app/data/repository/home_repository.dart';
import 'package:pa_template/app/modules/home_module/home_controller.dart';
import 'package:pa_template/app/modules/more_apps_module/more_apps_controller.dart';


class MoreAppsPage extends StatelessWidget {
  final MoreAppsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              crossAxisCount: context.isTablet ? 8 : 4,
              childAspectRatio: 6 / 10,
              shrinkWrap: true,
              children: List.generate(controller.listMoreApp.length, (index) {
                return GestureDetector(
                  onTap: () {
                    if (GetPlatform.isAndroid) {
                      LaunchReview.launch(
                          androidAppId: controller.listMoreApp[index].packageName,
                          writeReview: false);
                    } else {
                      HomeRepository(provider: HomeProvider()).fetchAppInfo(controller.listMoreApp[index].packageName).then((value) {
                        LaunchReview.launch(
                            iOSAppId: "${value.results[0].trackId}",
                            writeReview: false);
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/card_holder.png',
                              image: controller.listMoreApp[index].icon),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            controller.listMoreApp[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );

  }
}
