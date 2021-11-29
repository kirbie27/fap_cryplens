class FavoriteCoin {
  String favCoinID; //id in table

  //constructor for creating the record
  FavoriteCoin({
    required this.favCoinID,
  });

  //function to map the record

  Map<String, String> mapFavorites() {
    return {'favCoinID': favCoinID};
  }

  String toString() {
    return 'FavoriteCoin{favCoinID: $favCoinID}';
  }
}
