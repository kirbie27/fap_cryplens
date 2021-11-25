import 'dart:convert';
import 'package:cryplens/widgets/ArticleModel.dart';
import 'package:http/http.dart' as http;
import 'package:cryplens/widgets/SearchBar.dart';

class News {
  List<ArticleModel> news = [];

  getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=crypto&apiKey=08827c58e5d341d98840478ad934fcd8";
    //08827c58e5d341d98840478ad934fcd8 - Extra API
    //8e7a13b484d749b0ae127a968356a967"
    var response = await http.get(Uri.parse(url));

    print('here?');
    var jsonData = jsonDecode(response.body);
    int counter = 0;
    if (jsonData['status'] == "ok") {
      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"]);

          news.add(articleModel);
          print('article added');
        }
        counter = counter + 1;
        print(counter);
      }

      print('success news');
    } else {
      print('not ok');
    }
  }
}
