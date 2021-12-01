import 'dart:convert';
import 'package:cryplens/services/database/articleRecord.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:http/http.dart' as http;

class News {
  //default keyword for the search value, as adding crypto to the search relates
  //a value to the blockchain or crypto category.
  String defaultKeyword = 'crypto';

  getNewsAtLoad() async {
    //connects to the database;
    DatabaseHelper dbHelper = DatabaseHelper();
    String url =
        "https://newsapi.org/v2/everything?q=$defaultKeyword&pageSize=25&apiKey=8e7a13b484d749b0ae127a968356a967";
    //08827c58e5d341d98840478ad934fcd8 - Extra Key
    //8e7a13b484d749b0ae127a968356a967 - API Key
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    int counter = 0;

    //if jsonData has status ok that means the articles are properly returned.
    if (jsonData['status'] == "ok") {
      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null && element['description'] != null) {
          //places the data in a model for easy access
          ArticleRecord articleModel = ArticleRecord(
              articleId: counter,
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              publishedAt: element["publishedAt"]);

          counter = counter + 1;
          //inserts the article in the database.
          await dbHelper.insertNews(articleModel);
          print(counter);
        }
      }

      print('success news');
    } else {
      print('news not properly retrieved');
    }
  }

  //function for querying the api with a search value
  getNewsWithSearch(String keyword) async {
    String query = defaultKeyword;
    if (!keyword.isEmpty) query = keyword + " " + defaultKeyword;

    print(query);
    //connects to the database;

    DatabaseHelper dbHelper = DatabaseHelper();
    String url =
        "https://newsapi.org/v2/everything?q=$query&pageSize=25&apiKey=8e7a13b484d749b0ae127a968356a967";
    print(url);
    //08827c58e5d341d98840478ad934fcd8 - Extra API
    //8e7a13b484d749b0ae127a968356a967
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    int counter = 0;
    if (jsonData['status'] == "ok") {
      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleRecord articleModel = ArticleRecord(
              articleId: counter,
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              publishedAt: element["publishedAt"]);

          counter = counter + 1;
          await dbHelper.insertNews(articleModel);
          print(counter);
        }
      }

      print('success news');
    } else {
      print('news not properly retrieved');
    }
  }
}
