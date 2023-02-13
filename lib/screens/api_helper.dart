import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'models_class.dart';

class JockData {
  JockData._();

  static final JockData joksData = JockData._();

  Future<JoksData?> fetchJocksData() async {
    String url = "https://api.chucknorris.io/jokes/random";
    http.Response res = await http.get(
      Uri.parse(url),
    );

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);

      JoksData pratik = JoksData.fromJson(data: data);

      return pratik;
    }
  }
}
