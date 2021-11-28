import 'dart:convert';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:cryplens/services/database/coinRecord.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Crypto {
  String defaultKeyword = 'crypto';

  getCryptoAtLoad() async {
    //connects to the database;
    DatabaseHelper dbHelper = DatabaseHelper();
    String url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false";

    var response = await http.get(Uri.parse(url));
    print('here at crypto?');
    var jsonData = jsonDecode(response.body);
    int counter = 0;

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

    print('success crypto');
  }
}
