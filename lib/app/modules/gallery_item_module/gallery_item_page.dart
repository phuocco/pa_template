import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pa_template/app/modules/dialog_card_module/dialog_card_page.dart';
import 'package:pa_template/app/modules/gallery_item_module/gallery_item_controller.dart';
import 'package:pa_template/app/modules/gallery_module/gallery_tab.dart';
import 'package:pa_template/modules/card_module/card_model/card_detail_model.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class GalleryItemPage extends GetWidget<GalleryItemController> {

  final int index;
  final CardDetailModel cardDetailModel;
  final String id;
  final int rateCount;
  final double ratePoint;
  final double starAverage;

  GalleryItemPage(
      {
      this.index,
      this.cardDetailModel,
      this.id,
      this.rateCount,
      this.ratePoint,
      this.starAverage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: DialogCardPage(
            cardDetailModel: cardDetailModel,
            id: id,
            starAverage: starAverage,
          ),
        ),
        barrierDismissible: false,
      ),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.png',
                  image: cardDetailModel.thumbUrl),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBarIndicator(
                            rating: starAverage,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            unratedColor: Colors.white,
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.yellow),
                          ),
                          Row(
                            children: [
                              Text(
                                '$rateCount',
                                //style: kTextRateCountStyle,
                              ),
                              Icon(Icons.person,
                                  size: 12, color: Colors.grey[500]),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            starAverage.toStringAsPrecision(2),
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              cardDetailModel.yourName,
                              maxLines: 1,
                              // style: kTextCardAuthor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
