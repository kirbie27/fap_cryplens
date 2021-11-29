import 'dart:async';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'dart:math' as math;
import 'package:cryplens/screens/coin_page.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';

late List<dynamic> coins;

final List<String> SortByLabel = ["Market Cap", "Volume", "Price"];
final List<String> OrderByLabel = ["Descending", "Ascending"];
final List<String> SortByUrl = [
  "coinMarketCap",
  "coinTotalVolume",
  " coinPrice"
];
final List<String> OrderByUrl = ["desc", "asc"];

class CatalogPage extends StatefulWidget {
  _CatalogPageState createState() => _CatalogPageState();
}

bool loading = true;

class _CatalogPageState extends State<CatalogPage> {
  final GlobalKey<_SortWidgetState> _sortkey = GlobalKey();
  final GlobalKey<_SearchBarWidgetState> _searchkey = GlobalKey();
  String parent = 'parent';
  DatabaseHelper dbHelper = DatabaseHelper();

  late Future loader;
  void initState() {
    super.initState();
    loading = true;
    loader = getData();
  }

  searchCoin(String sort, String order, String search) {
    print(order);
    setState(() {
      loading = true;
    });
    updateCoinBySearch(sort, order, search);
  }

  updateCoinBySearch(String sort, String order, String search) async {
    final holder = await dbHelper.getCoinsTableWithSearch(sort, order, search);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      coins = dbHelper.coins;
      ;
      loading = false;
    });
  }

  changeSort(String sort, String order) {
    print(order);
    setState(() {
      loading = true;
    });
    sortCoins(sort, order);
  }

  sortCoins(String sort, String order) async {
    final holder = await dbHelper.getCoinsTableWithSort(sort, order);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      coins = dbHelper.coins;
      loading = false;
    });
  }

  getData() async {
    final holder = await dbHelper.getCoinsTableAtLoad();
    print('whut');
    setState(() {
      print('wew');
      coins = dbHelper.coins;
      loader = Future.value(holder);
      loading = false;
      print('changed to loading');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: SearchBarWidget(key: _searchkey, searchCrypto: searchCoin),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: SortWidget(key: _sortkey, sorting: changeSort),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
                  future: loader,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (!loading) {
                      return CoinListWidget();
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Loading],
                      );
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  Function searchCrypto;
  SearchBarWidget({required Key key, required this.searchCrypto})
      : super(key: key);
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

int toggle = 1;

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 250.0,
      alignment: Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 48.0,
        width: 300.0,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: kGray,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: 6.0,
              left: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff2f3f7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    child: Icon(
                      Icons.search,
                      color: kWhite,
                      size: 20.0,
                    ),
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 2.0 * math.pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 375),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: 23.0,
                  width: 180.0,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      setState(
                        () {
                          if (toggle == 0) {
                            //toggle = 1;
                            //_con.forward();
                          } else {
                            //toggle = 0;
                            //_textEditingController.clear();
                            //_con.reverse();
                          }
                        },
                      );
                      widget.searchCrypto(
                          SortByUrl[sortCount], OrderByUrl[orderCount], value);
                    },
                    style: TextStyle(color: kWhite),
                    enabled: !loading,
                    controller: _textEditingController,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    cursorColor: Colors.lightGreenAccent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Enter coin code...',
                      labelStyle: TextStyle(
                        color: Colors.white24,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: kGray,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon: Icon(
                  Icons.search,
                  color: kWhite,
                  size: 18.0,
                ),
                onPressed: () {
                  setState(
                    () {
                      if (toggle == 0) {
                        //toggle = 1;
                        //_con.forward();
                      } else {
                        //toggle = 0;
                        //_textEditingController.clear();
                        //_con.reverse();
                      }
                    },
                  );
                  widget.searchCrypto(SortByUrl[sortCount],
                      OrderByUrl[orderCount], _textEditingController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortWidget extends StatefulWidget {
  final Function sorting;
  SortWidget({required Key key, required this.sorting}) : super(key: key);
  @override
  _SortWidgetState createState() => _SortWidgetState();
}

int sortCount = 0;
int orderCount = 0;

class _SortWidgetState extends State<SortWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Sort by:",
                  style: TextStyle(
                    color: kWhite,
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sortCount = sortCount < 2 ? sortCount + 1 : 0;
                        orderCount = 0;
                      });
                      widget.sorting(
                          SortByUrl[sortCount], OrderByUrl[orderCount]);
                      print("Marketcap change");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Text(
                          SortByLabel[sortCount],
                          style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        orderCount = orderCount < 1 ? orderCount + 1 : 0;
                      });

                      widget.sorting(
                          SortByUrl[sortCount], OrderByUrl[orderCount]);
                      print("Order change");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Text(
                          OrderByLabel[orderCount],
                          style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoinListWidget extends StatefulWidget {
  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {
  @override
  Widget build(BuildContext context) {
    if (coins.length > 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          mainAxisExtent: 80,
        ),
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          return CoinContainer(
            index: index,
            coin: coins[index],
          );
        },
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            print('clicked empty coins');
          },
          child: Container(
            width: 500,
            height: 100,
            child: Center(
              child: Text(
                "No Coins found",
                style: TextStyle(
                  color: kWhite,
                  fontFamily: 'Spartan MB',
                  fontSize: 15.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kGray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    }
  }
}

class CoinContainer extends StatefulWidget {
  CoinContainer({required this.index, required this.coin});
  int index;
  Map coin;

  @override
  _CoinContainerState createState() => _CoinContainerState(
        index: index,
        coin: coin,
      );
}

class _CoinContainerState extends State<CoinContainer> {
  _CoinContainerState({required this.index, required this.coin});
  int index;
  Map coin;
  var coinPriceColor;
  @override
  Widget build(BuildContext context) {
    if (coin['coinPriceChange'] > 0) {
      coinPriceColor = kGreen;
    } else if (coin['coinPriceChange'] < 0) {
      coinPriceColor = kRed;
    } else {
      coinPriceColor = kWhite;
    }

    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CoinPage(coin: coin),
              ),
              (route) => false);
        },
        child: Container(
          width: 500,
          height: 500,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(coin['imageUrl']),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          coin['coinName'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(coin['coinSymbol'].toString().toUpperCase(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhite,
                              fontFamily: 'Spartan MB',
                              fontSize: 15.0,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "\$${coin['coinPrice']}",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: coinPriceColor,
                        fontFamily: 'Spartan MB',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: kGray,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
