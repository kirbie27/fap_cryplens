import 'dart:convert';
import 'models/detective_crypto_models.dart';
import 'package:http/http.dart' as http;

class DataService {
  late dynamic fromCoinGecko;

  getCoin(String text) async {
    //Future means data will be available at some time in the future
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    //api.coingecko.com/api/v3/coins/bitcoin

    final queryParameter = text.trim().toLowerCase().replaceAll(' ', '');
    final queryParameter2 = text.trim().toLowerCase().replaceAll(' ', '-');

    //make an if else for queryParameter = null then incase below statement

    var uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter');

    var response = await http.get(uri);
    print('ok lang');
    if (response.statusCode == 200) {
      print('200');
      //print(response.body);
    } else {
      print('hindi 200 status code');
      uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter2');
      print(queryParameter2);
      response = await http.get(uri);
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      fromCoinGecko = CoinResponse.fromJson(json);
    } else {
      fromCoinGecko = null;
    }
    print('tae');
  }
}
