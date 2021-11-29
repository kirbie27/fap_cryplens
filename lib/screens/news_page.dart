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
          //Search Bar
          Container(
            //color: Colors.green,
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: 500.0,
                  alignment: Alignment.center,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      setState(() {
                        loading = true;
                      });
                      getDataWithQuery(searchController.text);
                      setState(() {
                        searchController.clear();
                      });
                    },
                    style: TextStyle(color: kWhite),
                    enabled: !loading,
                    controller: searchController,
                    cursorWidth: 2.0,
                    cursorColor: Colors.lightGreenAccent,
                    focusNode: fn,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(left: 55.0),
                      labelText: 'Search about crypto here',
                      labelStyle: TextStyle(
                        color: Colors.white24,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0), color: kGray),
                ),
                Material(
                  color: kGray,
                  borderRadius: BorderRadius.circular(30.0),
                  child: IconButton(
                    // splashRadius: 19.0,
                    icon: Icon(
                      Icons.search,
                      color: kWhite,
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      getDataWithQuery(searchController.text);
                      setState(() {
                        searchController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

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
