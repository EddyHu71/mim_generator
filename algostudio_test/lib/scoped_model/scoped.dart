import 'package:algostudio_test/utils/module.dart';
import 'package:http/http.dart' as http;

class AlgoScoped extends Model {
  var _adalistmeme = true;
  final _listMeme = List<Memes>();
  get adalistmeme {
    return _adalistmeme;
  }

  List<Memes> get listmeme {
    return _listMeme;
  }

  notifyListens(String routes, bool condition) {
    switch (routes) {
      case "list_meme":
        _adalistmeme = condition;
        break;
    }
    notifyListeners();
  }

  getMeme() async {
    print("Get meme executed");
    notifyListens("list_meme", true);
    var data = await http.get("https://api.imgflip.com/get_memes");
    var jsons = jsonDecode(data.body);
    // print(jsons);
    if (jsons["success"] == true) {
      jsons['data']['memes'].forEach((x) {
        final memes = Memes.fromJson(x);
        listmeme.add(memes);
      });
    } else {}
    notifyListens("list_meme", false);
  }
}
