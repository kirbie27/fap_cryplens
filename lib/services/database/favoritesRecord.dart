class FavoriteCoin {
  int favCoinId; //id in table
  String favCoinName;
  String favCoinKey; //id in jason
  String favCoinSymbol;
  String? favCoinImage;

  //constructor for creating the record
  FavoriteCoin(
      {required this.favCoinId,
      required this.favCoinName,
      required this.favCoinKey,
      required this.favCoinSymbol,
      this.favCoinImage});

  //function to map the record

  Map<String, dynamic> mapFavorites() {
    return {
      'favCoinId': favCoinId,
      'favCoinName': favCoinName,
      'favCoinKey': favCoinKey,
      'favCoinSymbol': favCoinSymbol,
      'favCoinImage': favCoinImage == null ? favCoinImage : 'No Image'
    };
  }

  String toString() {
    favCoinImage = favCoinImage == null ? favCoinImage : 'No Image';
    return 'FavoriteCoin{favCoinId: $favCoinId, favCoinName: $favCoinName, favCoinKey: $favCoinKey, favCoinSymbol: $favCoinSymbol,favCoinImage: $favCoinImage}';
  }
}
