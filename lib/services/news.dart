import 'dart:convert';
import 'package:cryplens/widgets/ArticleModel.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=8e7a13b484d749b0ae127a968356a967";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"]
          );

          news.add(articleModel);
        }
      });
    }
  }
}