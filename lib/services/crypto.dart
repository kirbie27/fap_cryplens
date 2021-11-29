import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:cryplens/services/database/coinRecord.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Crypto {
  String defaultKeyword = 'crypto';
  late List chartOHLC = [];
  getCryptoAtLoad() async {
    //connects to the database;
    DatabaseHelper dbHelper = DatabaseHelper();
    int counter = 0;
    for (int i = 1; i <= 2; i++) {
      String url =
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=200&page=$i&sparkline=false";
      var response = await http.get(Uri.parse(url));
      print('here at crypto?');
      var jsonData = jsonDecode(response.body);
      for (var element in jsonData) {
        counter = counter + 1;
        var coin = CoinRecord(
            coinID: element['id'],
            coinSymbol: element['symbol'],
            coinName: element['name'],
            imageUrl: element['image'],
            coinPrice: element['current_price'].toDouble(),
            coinMarketCap: element['market_cap'].toDouble(),
            coinMarketCapRank: element['market_cap_rank'],
            coinTotalVolume: element['total_volume'].toDouble(),
            coinPriceChange: element['price_change_24h'].toDouble());
        await dbHelper.insertCoins(coin);
        print(counter);
        //print('Crypto # $counter: ${coin.toString()}');
      }
    }

    print('success crypto');
  }

  getCryptoChart(String coinID, String range) async {
    //connects to the database;
    DatabaseHelper dbHelper = DatabaseHelper();
    int counter = 0;

    String url =
        "https://api.coingecko.com/api/v3/coins/$coinID/ohlc?vs_currency=usd&days=$range";

    var response = await http.get(Uri.parse(url));
    print('here at crypto charts?');
    var jsonData = jsonDecode(response.body);
    for (int i = 0; i < jsonData.length; i++) {
      counter = counter + 1;
      int unix = jsonData[i][0];
      double O = jsonData[i][1];
      double H = jsonData[i][2];
      double L = jsonData[i][3];
      double C = jsonData[i][4];
      Map coinOHLC = {'unix': unix, 'O': O, 'H': H, 'L': L, 'C': C};
      chartOHLC.add(coinOHLC);
      print(counter);
    }

    print('success crypto');
  }
}
