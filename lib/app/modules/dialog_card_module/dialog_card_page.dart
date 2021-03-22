import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/dialog_card_module/dialog_card_controller.dart';
import 'package:pa_template/functions/util_functions.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardPage extends GetWidget<DialogCardController> {
  final controller = Get.put(DialogCardController());
  final CardDetailModel cardDetailModel;
  final String id;
  final double starAverage;

  DialogCardPage({this.cardDetailModel, this.id, this.starAverage});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: GetBuilder<DialogCardController>(
        initState: (state) {
          Get.find<DialogCardController>().setSize();
          controller.getSharedPref();
          controller.checkRated(id);
        },
        builder: (controller) => Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: controller.heightCard * 0.85,
                    maxWidth: controller.widthCard * 0.85),
                child: LayoutBuilder(
                  builder: (context, cons) {
                    //region cal box
                    var width = cons.biggest.width;
                    var height = cons.biggest.height;
                    var baseRatio =
                        controller.widthCard / controller.heightCard;
                    var useHeight = width / height > baseRatio;
                    var calHeight = width / baseRatio;
                    var newCardHeight = useHeight ? height : calHeight;
                    var newCardW = newCardHeight * baseRatio;
                    var marginRight = (width - newCardW) / 2;
                    var marginTop = (height - newCardHeight) / 2;
                    //endregion
                    return Container(
                      child: Stack(
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              height: newCardHeight,
                              fit: BoxFit.fitHeight,
                              placeholder: (context, value) {
                                return Image.asset(
                                  "assets/images/loading.png",
                                  height: newCardHeight,
                                );
                              },
                              imageUrl: cardDetailModel.cardPath,
                            ),
                          ),
                          Positioned(
                            top: marginTop,
                            right: marginRight,
                            child: GestureDetector(
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white24,
                                  size: newCardW * 0.1,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: controller.widthCard),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Obx(() => AbsorbPointer(
                          // absorbing: isRated,
                          absorbing: controller.isRated.value,
                          child: RatingBar(
                              initialRating: 1,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              tapOnlyMode: true,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                ),
                                empty: Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.green,
                                ),
                              ),
                              onRatingUpdate: (point) {
                                print(point);
                                controller.rateCard(id);
                                controller.isRated.value = true;
                              }),
                        ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            Colors.blue,
                          )),
                          child: Text(
                            'COPY CARD',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            print(controller.isRated.value);
                            print('copy card');
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () => print('share'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.flag,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () async {
                                print('check reported');
                                Get.snackbar(
                                  'Cannot report',
                                  'You\'ve already report this card',
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          UtilFunctions().getHeightBanner()),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
