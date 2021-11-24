import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/screens/manual_page.dart';
import 'package:cryplens/widgets/SearchBar.dart';
import 'package:cryplens/widgets/ArticleModel.dart';
import 'package:cryplens/services/news.dart';
import 'package:cryplens/widgets/NewsTile.dart';

class NewsPage extends StatefulWidget {
  NewsPage();
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: Column(
              children: [
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Find news about coin:',
                          style: kMessageTextStyle, textAlign: TextAlign.left)),
                ),
                SafeArea(child: SearchBar()),
                // SafeArea(
                //   child: Container(
                //     padding: EdgeInsets.all(100),
                //     height: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: kWhite,
                //     ),
                //   ),
                // ),
                //ARTICLES
                _loading
                    ? SafeArea(
                      child: Container(
                  child: Container(child: CircularProgressIndicator()),
                ),
                    )
                    :
                Container(
                  child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(articles[index].title);
                        return NewsTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                        );
                      }),
                )
              ],
            ),
    );
  }
}
