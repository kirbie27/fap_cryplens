import 'dart:convert';
import 'models/detective_crypto_models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<CoinResponse> getCoin(String text) async {
    //Future means data will be available at some time in the future
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    //api.coingecko.com/api/v3/coins/bitcoin

    final queryParameter = text.trim().replaceAll(' ', '');
    final queryParameter2 = text.trim().replaceAll(' ', '-');

    //make an if else for queryParameter = null then incase below statement

    var uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter');

    var response = await http.get(uri);
    print('ok lang');
    if (response.statusCode == 200) {
      print('gumana');
      print(response.body);
    } else {
      print('hindi 200 status code');
      uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter2');
      print(queryParameter2);
      response = await http.get(uri);
    }

    final json = jsonDecode(response.body);
    return CoinResponse.fromJson(json);
  }
}
