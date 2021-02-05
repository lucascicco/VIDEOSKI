import 'dart:async';
import 'dart:convert';
import 'package:animationmusic/app/services/getDataInt.dart';
import 'package:http/http.dart' as http;

class GetDataClass implements GetDataContract {
  @override
  Future<Map> getData(String url) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$url&format=json";

    //store http request response to res variable
    var res = await http.get(embedUrl);

    try {
      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return null;
      }
    } on FormatException catch (e) {
      return null;
    }
  }
}
