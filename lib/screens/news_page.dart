//import 'package:cryplens/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/services/news.dart';
import 'package:cryplens/widgets/NewsTile.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future articles;
  String test = '';

  void initState() {
    super.initState();
    articles = getData();
  }

  getData() async {
    final newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = Future.value(dbHelper.getNewsTable());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Find news about crypto:',
                      style: kMessageTextStyle, textAlign: TextAlign.left)),
            ),
          ),
          //SearchBar(),
          //ARTICLES
          FutureBuilder(
            future: articles,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data != null) {
                //print(snap.data);
                return Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      for (var i in snap.data)
                        NewsTile(
                          imageUrl: i['urlToImage'],
                          title: i['title'],
                          desc: i['description'],
                          url: i['url'],
                        )
                    ],
                  )),
                );
              } else {
                return Expanded(
                  flex: 9,
                  child: Center(
                      child: Container(child: Loading)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
