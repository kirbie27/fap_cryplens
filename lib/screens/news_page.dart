//import 'package:cryplens/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/services/news.dart';
import 'package:cryplens/widgets/NewsTile.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/rendering.dart';
import 'package:cryplens/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({required Key key}) : super(key: key);
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
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

  Future<void> NewsInstructions() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'How to Use CryptoPages',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              '1. The cryptopages shows the top 25 headlines about cryptocurrencies.'
              '\n\n2. You can search for news about a specific coin using the search bar. '
              '\n\n3. You can also tap on the specific news tile in order'
              ' to see more details about the articles.'
              '\n\n4. Lastly, this is where you will be redirected when you tap the See Related News'
              ' of a specific coin page from the catalog.',
              textAlign: TextAlign.justify,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                color: kGreen,
                child: Text('OK',
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  getData() async {
    final holder = await dbHelper.getNewsTableAtLoad();

    setState(() {
      articles = DatabaseHelper.news;
      loading = false;
      loader = Future.value(holder);
    });
  }

  getDataWithQuery(String query) async {
    print('magsesearch!');
    final holder = await dbHelper.getNewsTableWithQuery(query);

    setState(() {
      articles = DatabaseHelper.news;
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
            margin: EdgeInsets.all(15.0),
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
