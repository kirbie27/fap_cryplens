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
  bool searching = false;
  late Future articles;
  String test = '';

  void initState() {
    super.initState();
    if (!searching) articles = getData();

    searching = false;
  }

  getData() async {
    final newsClass = News();
    final holder = await dbHelper.getNewsTableAtLoad();
    setState(() {
      articles = Future.value(holder);
    });
  }

  getDataWithQuery(String query) async {
    final newsClass = News();
    final holder = await dbHelper.getNewsTableWithQuery(query);
    setState(() {
      searching = true;
      articles = Future.value(holder);
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode fn = FocusNode();

    void dispose() {
      fn.dispose();
      super.dispose();
    }

    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextField(
                cursorColor: kBlue,
                focusNode: fn,
                style: TextStyle(
                  fontSize: 20,
                ),
                controller: searchController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.adb),
                    onPressed: () {
                      getDataWithQuery(searchController.text);
                    },
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlue, width: 1),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  hintText: 'Search about crypto here',
                  contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                ),
              ),
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
                  child: Center(child: Container(child: Loading)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
