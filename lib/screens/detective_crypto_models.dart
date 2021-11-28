/* EXAMPLE of JSON
{
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
  },

  "name": "Mountain View",
}

{
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "asset_platform_id": null,
  "platforms": {
    "": ""
  },
  "block_time_in_minutes": 10,
  "hashing_algorithm": "SHA-256",
  "categories": [
    "Cryptocurrency"
  ],
  "public_notice": null,
  "additional_notices": [],
  "description": {
    "en": "Bitcoin i...
    },
  "sentiment_votes_up_percentage": 64.48,
  "sentiment_votes_down_percentage": 35.52,
  "market_data": {
    "current_price": {
      "btc": 1,
      "eth": 13.323131,
      "eur": 47826,
      "php": 2733899,
      "usd": 54139,
    },
  },
  "genesis_date": "2009-01-03",
  "sentiment_votes_up_percentage": 64.49,
  "sentiment_votes_down_percentage": 35.51,
  "market_cap_rank": 1,
  "coingecko_rank": 1,
  "coingecko_score": 80.393,
  "developer_score": 98.883,
  "community_score": 70.995,
  "liquidity_score": 100.264,

*/

class CoinInfo{
  final double sentiment_votes_up_percentage;
  final double sentiment_votes_down_percentage;

  CoinInfo({required this.sentiment_votes_up_percentage, required this.sentiment_votes_down_percentage});

  factory CoinInfo.fromJson(Map<String, dynamic> json){ //JSON is a map, and in this case, it is a map of String and dynamic
    //dynamic can change type and value later
    final sentimentVotesUpPercentage = json['sentiment_votes_up_percentage'];
    final sentimentVotesDownPercentage = json['sentiment_votes_down_percentage'];
    return CoinInfo(sentiment_votes_up_percentage: sentimentVotesUpPercentage, sentiment_votes_down_percentage: sentimentVotesDownPercentage);
  }
}

class CurrentPriceInfo{
  final String current_price;

  CurrentPriceInfo({required this.current_price});

  factory CurrentPriceInfo.fromJson(Map<String, dynamic> json){
    final currentPrice = json['current_price'];
    return CurrentPriceInfo(current_price: currentPrice);
  }
}

class CoinResponse {
  final String id;
  final CurrentPriceInfo currentPriceInfo;
  final CoinInfo coinInfo;
  final CoinInfo coinInfo1;

  CoinResponse({required this.id, required this.currentPriceInfo, required this.coinInfo, required this.coinInfo1}); //

  factory CoinResponse.fromJson(Map<String, dynamic> json){ //Factory is a custom constructor with codes to create that constructor
    final id = json['id'];

    final currentPriceInfoJson = json['market_data'];
    final currentPriceInfo = CurrentPriceInfo.fromJson(currentPriceInfoJson);

    final coinInfoJson = json['sentiment_votes_up_percentage'];
    final coinInfo = CoinInfo.fromJson(coinInfoJson);

    final coinInfoJson1 = json['sentiment_votes_down_percentage'];
    final coinInfo1 = CoinInfo.fromJson(coinInfoJson1);

    return CoinResponse(id: id, currentPriceInfo: currentPriceInfo, coinInfo: coinInfo, coinInfo1: coinInfo1); //
  }
}