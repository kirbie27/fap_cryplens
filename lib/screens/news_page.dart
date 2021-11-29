//import 'package:cryplens/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/services/news.dart';
import 'package:cryplens/widgets/NewsTile.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/rendering.dart';
import 'package:cryplens/search.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Search search = Search();
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future loader;
  late var articles;
  bool loading = true;

  void initState() {
    super.initState();
    print('nasa init state!');
    print('test');
    loading = true;

    String s = search.getSearch();
    if (s == null)
      loader = getData();
    else {
      loader = getDataWithQuery(s);
      search.resetSearch();
    }
    //articles = getData();
  }

  getData() async {
    final holder = await dbHelper.getNewsTableAtLoad();

    setState(() {
      articles = dbHelper.news;
      loading = false;
      loader = Future.value(holder);
    });
  }

  getDataWithQuery(String query) async {
    print('magsesearch!');
    final holder = await dbHelper.getNewsTableWithQuery(query);

    setState(() {
      articles = dbHelper.news;
      loading = false;
      loader = Future.value(holder);
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: TextField(
                    cursorColor: kBlue,
                    focusNode: fn,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    controller: searchController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.adb),
                      //   onPressed: () {
                      //     setState(() {
                      //       loading = true;
                      //     });
                      //     getDataWithQuery(searchController.text);
                      //   },
                      // ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBlue, width: 1),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Search about crypto here',
                      contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(top: 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.white),
                  child: Container(
                    height: 42,
                    width: 42,
                    child: Icon(
                      Icons.search,
                      color: kBlue,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    getDataWithQuery(searchController.text);
                  },
                ),
              )
            ],
          ),

          //SearchBar(),
          //ARTICLES
          FutureBuilder(
            future: loader,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (!loading) {
                return Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      if (!articles.isEmpty)
                        for (var i in articles)
                          NewsTile(
                            imageUrl: i['urlToImage'],
                            title: i['title'],
                            desc: i['description'],
                            url: i['url'],
                          )
                      else
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'We couldn\'t find what you are looking for, Agent.',
                                  style: kMessageTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Image.asset(
                                "assets/images/cryplensLOGOWHITE.png",
                                height: 200,
                              )
                            ],
                          ),
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
