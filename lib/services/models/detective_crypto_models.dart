class CoinResponse {
  final String name;
  final String id;
  final String symbol;
  final String img;
  final String assetPlatformID;
  final String platforms;
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
      required this.img,
      required this.assetPlatformID,
      required this.platforms,
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
    final img = json['image']['large'];
    final assetPlatformID = json['asset_platform_id'];
    final platforms = json['platforms'][assetPlatformID];
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
        img: img,
        assetPlatformID: assetPlatformID,
        platforms: platforms,
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
