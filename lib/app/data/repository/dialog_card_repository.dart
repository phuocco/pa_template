import 'package:pa_template/app/data/provider/dialog_card_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class DialogCardRepository {
  final DialogCardProvider provider;

  DialogCardRepository({@required this.provider}) : assert(provider != null);

    rateCard(String id, double point){
      print('repo');
      return provider.rateCard(id, point);

    }


}