import 'dart:async';
import 'package:cryplens/services/database/coinRecord.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cryplens/services/database/favoritesRecord.dart';
import 'package:cryplens/services/database/articleRecord.dart';
import 'package:cryplens/services/news.dart';
import 'package:cryplens/services/crypto.dart';

//this class handles the functions related to the databas
class DatabaseHelper {
  static var _database;
  static String _databaseName = 'cryptolens.db';
  static var dbversion = 1;
  static late List news;
  static late List coins;
  static late List favs;
  //database connection methods
  Future<Database> getDatabase() async {
    if (_database == null) _database = await connectDatabase();
    return _database;
  }

  //only called when database is not yet connected
  connectDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: dbversion,
    );
    print('connected');
    return database;
  }
  //database connectoin methods end

  //database methods for the favorite coins
  createFavCoinsTable() async {
    final db = await getDatabase();
    await db.execute(
        'CREATE TABLE IF NOT EXISTS favcoins(favCoinID TEXT PRIMARY KEY)');
  }

  getFavCoinsTable() async {
    final db = await getDatabase();
    await createFavCoinsTable();
    favs = await db.rawQuery(
        "SELECT * FROM coins INNER JOIN favcoins on coins.coinID = favcoins.favCoinID");
    return await db.rawQuery(
        "SELECT * FROM coins INNER JOIN favcoins on coins.coinID = favcoins.favCoinID");
  }

  deleteFavCoin(String favCoinID) async {
    final db = await getDatabase();
    await createFavCoinsTable();
    await db
        .rawDelete('DELETE FROM favcoins WHERE favCoinID = ?', ['$favCoinID']);
    print('nadelete si $favCoinID');
  }

  searchFavCoin(String favCoinID) async {
    final db = await getDatabase();
    await createFavCoinsTable();
    return await db
        .rawQuery("SELECT * FROM favcoins WHERE favCoinID = '$favCoinID'");
  }

  Future<void> insertFavCoin(Map<String, String> fav) async {
    // Get a reference to the database.
    final db = await getDatabase();
    await createFavCoinsTable();
    await db.insert(
      'favcoins', //table name
      fav, //specific favcoin object
      conflictAlgorithm:
          ConflictAlgorithm.replace, //replaces that entry if in conflict
    );
  }
  // favorite coins database methods end.

  //database methods for the news
  createNewsTable() async {
    final db = await getDatabase();
    await db.execute(
        'CREATE TABLE IF NOT EXISTS news(articleId INTEGER PRIMARY KEY, author TEXT, title TEXT, description TEXT,url TEXT, urlToImage TEXT,content TEXT,publishedAt TEXT )');
  }

  getNewsTableAtLoad() async {
    final db = await getDatabase();
    await createNewsTable();
    await db.execute("DROP TABLE IF EXISTS news");
    await createNewsTable();
    var newsTable = await db.query('news');
    final newsClass = News();
    await newsClass.getNewsAtLoad();
    news = await db.query('news');
    return await db.query('news');
  }

  getNewsTableWithQuery(String query) async {
    final db = await getDatabase();
    //print('anditoo!');
    //since this is a new query we would need to reload the table
    await db.execute("DROP TABLE IF EXISTS news");
    await createNewsTable();
    var newsTable = await db.query('news');
    //print('wala pa lamana: $news');

    final newsClass = News();

    await newsClass.getNewsWithSearch(query);
    news = await db.query('news');
    // print('dapat may laman na dito: $news');
    return await db.query('news');
  }

  Future<void> insertNews(ArticleRecord article) async {
    // Get a reference to the database.
    final db = await getDatabase();
    //try to create table if it doesn't exist
    await createNewsTable();
    //insert the news object, by replacing the similar occurence.
    await db.insert(
      'news', //table name
      article.mapArticles(), //specific favcoin object
      conflictAlgorithm:
          ConflictAlgorithm.replace, //replaces that entry if in conflict
    );
  }
  // news database methods end.

  //database methods for the coins
  createCoinsTable() async {
    final db = await getDatabase();
    await db.execute('CREATE TABLE IF NOT EXISTS coins('
        'coinID TEXT PRIMARY KEY, '
        'coinSymbol TEXT, '
        'coinName TEXT, '
        'imageUrl TEXT,'
        'coinPrice REAL,'
        'coinMarketCap REAL,'
        'coinMarketCapRank INTEGER , '
        'coinTotalVolume REAL, '
        'coinPriceChange REAL)');
    //return await db.query();
  }

  getCoinsFromDatabase() async {
    final db = await getDatabase();
    coins = await db.query('coins');
  }

  getCoinsTableAtLoad() async {
    final db = await getDatabase();
    await createCoinsTable();
    await db.execute("DROP TABLE IF EXISTS coins");
    await createCoinsTable();
    var coinsTable = await db.query('coins');
    final coin = Crypto();
    await coin.getCryptoAtLoad();
    coins = await db.query('coins');
    return await db.query('coins');
  }

  getCoinsTableWithSort(String sort, String order) async {
    final db = await getDatabase();
    coins = await db.rawQuery('SELECT * FROM coins order by $sort $order');
    return await db.rawQuery('SELECT *  FROM coins order by $sort $order');
  }

  getCoinsTableWithSearch(String sort, String order, String search) async {
    final db = await getDatabase();

    coins = await db.rawQuery(
        "SELECT * FROM coins WHERE coinID LIKE '%$search%' OR coinSymbol LIKE '%$search%' OR coinName LIKE '%$search%'");
    return await db.rawQuery(
        "SELECT * FROM coins WHERE coinID LIKE '%$search%' OR coinSymbol LIKE '%$search%' OR coinName LIKE '%$search%'");
  }

  Future<void> insertCoins(CoinRecord coin) async {
    // Get a reference to the database.
    final db = await getDatabase();
    //try to create table if it doesn't exist
    await createCoinsTable();
    //insert the news object, by replacing the similar occurence.
    await db.insert(
      'coins', //table name
      coin.mapCoins(), //specific
      conflictAlgorithm:
          ConflictAlgorithm.replace, //replaces that entry if in conflict
    );
  }
  // coins database methods end.

}
