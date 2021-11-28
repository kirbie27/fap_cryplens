class CoinRecord {
  String coinID; //id in table
  String coinSymbol; //shortened name
  String coinName;
  String imageUrl; //url of logo image
  double coinPrice;
  double coinMarketCap;
  int coinMarketCapRank;
  double coinTotalVolume;
  double coinPriceChange;

  CoinRecord(
      {required this.coinID, //id in table
      required this.coinSymbol, //shortened name
      required this.coinName,
      required this.imageUrl, //url of logo image
      required this.coinPrice,
      required this.coinMarketCap,
      required this.coinMarketCapRank,
      required this.coinTotalVolume,
      required this.coinPriceChange});

  Map<String, dynamic> mapCoins() {
    return {
      'coinID': coinID, //id in table
      'coinSymbol': coinSymbol, //shortened name
      'coinName': coinName,
      'imageUrl': imageUrl, //url of logo image
      'coinPrice': coinPrice,
      'coinMarketCap': coinMarketCap,
      'coinMarketCapRank': coinMarketCapRank,
      'coinTotalVolume': coinTotalVolume,
      'coinPriceChange': coinPriceChange
    };
  }

  String toString() {
    return 'CoinRecord{'
        'coinID: $coinID, coinSymbol: $coinSymbol,coinName: $coinName,imageUrl: $imageUrl, coinPrice: $coinPrice, coinMarketCap: $coinMarketCap, coinMarketCapRank: $coinMarketCapRank, coinTotalVolume: $coinTotalVolume, coinPriceChange: $coinPriceChange }';
  }
}
