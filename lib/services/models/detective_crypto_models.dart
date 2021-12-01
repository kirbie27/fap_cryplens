/* EXAMPLE of JSON
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

class CoinResponse {
  final String name;
  final String id;
  final String symbol;
  final double liquidityScore;
  final double developerScore;
  final double communityScore;
  final double coingeckoScore;
  final int coingeckoRank;
  final double sentimentVoteUpPercentage;
  final double sentimentVoteDownPercentage;

  CoinResponse(
      {required this.name,
      required this.id,
      required this.liquidityScore,
      required this.developerScore,
      required this.communityScore,
      required this.coingeckoScore,
      required this.coingeckoRank,
      required this.symbol,
      required this.sentimentVoteUpPercentage,
      required this.sentimentVoteDownPercentage});

  factory CoinResponse.fromJson(dynamic json) {
    //Factory is a custom constructor with codes to create that constructor
    final name = json['name'];
    final id = json['id'];
    final liquidityScore = json['liquidity_score'];
    final developerScore = json['developer_score'];
    final communityScore = json['community_score'];
    final coingeckoScore = json['coingecko_score'];
    final coingeckoRank = json['coingecko_rank'];
    final symbol = json['symbol'];
    final sentimentVoteUpPercentage = json['sentiment_votes_up_percentage'];
    final sentimentVoteDownPercentage = json['sentiment_votes_down_percentage'];

    return CoinResponse(
        name: name,
        id: id,
        liquidityScore: liquidityScore,
        developerScore: developerScore,
        communityScore: communityScore,
        coingeckoScore: coingeckoScore,
        coingeckoRank: coingeckoRank,
        symbol: symbol,
        sentimentVoteUpPercentage: sentimentVoteUpPercentage,
        sentimentVoteDownPercentage: sentimentVoteDownPercentage);
  }
}
