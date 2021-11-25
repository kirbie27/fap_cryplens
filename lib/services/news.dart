import 'dart:convert';
import 'package:cryplens/widgets/ArticleModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=blockchain&apiKey=8e7a13b484d749b0ae127a968356a967";

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
