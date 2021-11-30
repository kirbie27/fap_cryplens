import 'dart:convert';
import 'detective_crypto_models.dart';
import 'package:http/http.dart' as http;

class DataService{
  Future<CoinResponse> getCoin(String text) async { //Future means data will be available at some time in the future
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    //api.coingecko.com/api/v3/coins/bitcoin

    final queryParameter = text.replaceAll(' ', '');

    //make an if else for queryParameter = null then incase below statement

    final uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter');

    final response = await http.get(uri);

    if(response.statusCode == 200){
      print('gumana');
      print(response.body);
    } else {
      print('hindi 200 status code');
    }

    final json = jsonDecode(response.body);
    return CoinResponse.fromJson(json);
  }
}