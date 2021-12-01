import 'dart:convert';
import 'package:cryplens/services/database/articleRecord.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:cryplens/widgets/SearchBar.dart';

class News {
  String defaultKeyword = 'crypto';

  getNewsAtLoad() async {
    //connects to the database;
    DatabaseHelper dbHelper = DatabaseHelper();
    String url =
        "https://newsapi.org/v2/everything?q=$defaultKeyword&pageSize=25&apiKey=8e7a13b484d749b0ae127a968356a967";
    //08827c58e5d341d98840478ad934fcd8 - Extra Key
    //8e7a13b484d749b0ae127a968356a967 - API Key
    var response = await http.get(Uri.parse(url));
    print('here?');
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
      print('not ok');
    }
  }

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
    print('here?');
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
      print('not ok');
    }
  }
}
