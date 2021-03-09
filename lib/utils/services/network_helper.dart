import 'package:http/http.dart' as http;
import 'package:pa_template/modules/gallery_module/model/gallery_model.dart';

import '../../modules/card_module/card_model/card_detail_model.dart';
import '../../modules/card_module/card_model/card_detail_model.dart';
import '../../modules/card_module/card_model/card_detail_model.dart';
import '../../modules/card_module/card_model/card_detail_model.dart';
import '../../modules/card_module/card_model/card_model.dart';
class NetworkHelper {
  final String url;
  NetworkHelper({this.url});

  Future getGallery() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = galleryCardFromJson(data);
      print(response.statusCode);
      return decodedData;
    } else {
      print('error' + response.statusCode.toString());
      return galleryCardFromJson("[]");
    }
  }

  Future getCard() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = cardModelFromJson(data);
      print(response.statusCode);
      return decodedData;
    } else {
      print('error' + response.statusCode.toString());
      return null;
    }
  }


}

