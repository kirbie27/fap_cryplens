class coinRecord {
  int coinID; //id in table
  String cgID; //coingecko id
  String coinName;
  String imageUrl; //url of logo image
  String coinSymbol; //shortened name
  double coinCurrentPrice;
  double coinPreviousPrice;
  double coinMarketCap;
  int coinMarketCapRank;
  int coinCirculatingSupply;
  int coinTotalSupply;
  int coinMaxSupply;
  double coinATH;

  coinRecord({
    required this.coinID, //id in table
    required this.cgID, //coingecko id
    required this.coinName,
    required this.imageUrl, //url of logo image
    required this.coinSymbol, //shortened name
    required this.coinCurrentPrice,
    required this.coinPreviousPrice,
    required this.coinMarketCap,
    required this.coinMarketCapRank,
    required this.coinCirculatingSupply,
    required this.coinTotalSupply,
    required this.coinMaxSupply,
    required this.coinATH,
  });
}
