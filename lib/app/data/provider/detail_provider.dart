
import 'package:get/get_connect/connect.dart';
import 'package:mods_guns/models/addons_item.dart';


const baseUrl = 'https://mcpecenter.com/mine-craft-sv/index.php/MainHome/get_hot_items_home';

class DetailProvider extends GetConnect {

  getItem() async {

      final response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        var data = response.bodyString;
        var decodedData = addonsItemFromJson(data);
        print(response.statusCode);
        return decodedData;
      } else {
        print('error' + response.statusCode.toString());
        return addonsItemFromJson("[]");
      }
  }

}
