import 'dart:convert';
import 'models/detective_crypto_models.dart';
import 'models/whitepaper.dart';
import 'package:http/http.dart' as http;

class DataService {
  late dynamic fromCoinGecko;
  late dynamic coinWhitePaper;
  final tokenSnifferKey = '';
  getCoin(String text) async {
    final queryParameter = text.trim().toLowerCase().replaceAll(' ', '');
    final queryParameter2 = text.trim().toLowerCase().replaceAll(' ', '-');

    var uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter');

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('200');
    } else {
      uri = Uri.https('api.coingecko.com', '/api/v3/coins/$queryParameter2');
      response = await http.get(uri);
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      fromCoinGecko = CoinResponse.fromJson(json);
      //retrieve data for whitepaper and tokensniffer
      await getWhitePaper(fromCoinGecko.symbol.toUpperCase());
    } else {
      //sets the variables to null to tell the application that there was no data returned by the api.
      fromCoinGecko = null;
      coinWhitePaper = null;
    }
  }

  getWhitePaper(String symbol) async {
    var url = 'https://api.whitepaper.io/lookup?code=${symbol}';
    var response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    //checks if the json is a list to know if there is data returned by the api for the white paper
    if (json is List) {
      //if list that means that the json returned the whitepaper of the specefic coin.
      coinWhitePaper = WhitePaper(json[0]['name'], json[0]['documentUrl']);
    } else {
      coinWhitePaper = WhitePaper('BLANK', 'BLANK');
    }
    print(coinWhitePaper.toString());
    //print(response.body);
  }
}
