import 'package:cryplens/screens/coin_page.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:cryplens/user.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:cryplens/screens/navigation.dart';

//dummy list of coins before api, you may change the number of generated coins
late List<dynamic> favcoins = [
  {'id': 0, 'name': '+', 'title': '', 'image': 'assets/images/AddIcon.png'}
];

class PouchPage extends StatefulWidget {
  @override
  _PouchPageState createState() => _PouchPageState();
}

bool loading = true;

class _PouchPageState extends State<PouchPage> {
  User user = User();
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future loader;

  void initState() {
    super.initState();
    loading = true;
    loader = getData();
  }

  getData() async {
    final holder = await dbHelper.getFavCoinsTable();
    print('hello pouch');
    setState(() {
      favcoins = [
        {
          'id': 0,
          'name': 'Add Coin',
          'title': '',
          'image': 'assets/images/AddIcon.png'
        }
      ];
      favcoins.addAll(holder);
      print(holder);
      loader = Future.value(holder);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text(
                  'Hi ${user.getName()}, I listed here the contents of your pouch',
                  textAlign: TextAlign.center,
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
            flex: 4,
            child: FutureBuilder(
                future: loader,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (!loading) {
                    return CoinWidget();
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
    );
  }
}

class CoinWidget extends StatefulWidget {
  const CoinWidget({Key? key}) : super(key: key);

  @override
  _CoinWidgetState createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> {
  @override
  Widget build(BuildContext context) {
    if (favcoins.length > 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 250,
        ),
        itemCount: favcoins.length,
        itemBuilder: (BuildContext context, int index) {
          return CoinContainer(index: index, favcoin: favcoins);
        },
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            print('clicked');
          },
          child: Container(
            width: 500,
            height: 500,
            child: Center(
              child: Text(
                "Add new coins from the coin catalog",
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
  CoinContainer({required this.index, required this.favcoin});
  final int index;
  final List favcoin;
  @override
  _CoinContainerState createState() =>
      _CoinContainerState(index: index, favcoin: favcoin);
}

class _CoinContainerState extends State<CoinContainer> {
  _CoinContainerState({required this.index, required this.favcoin});
  final int index;
  final List favcoin;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (index != 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CoinPage(coin: favcoin[index]),
                ),
                (route) => false);
          } else {
            NavigatorPage.fromSearch = true;
            Navigator.of(context).pushNamedAndRemoveUntil(
                NavigatorPage.routeName, (route) => false,
                arguments: {'index': 0});
          }
        },
        child: Container(
          width: 500,
          height: 500,
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        index == 0
                            ? favcoins[index]['title']
                            : favcoins[index]['coinSymbol']
                                .toString()
                                .toUpperCase(),
                        style: TextStyle(
                          color: kWhite,
                          fontFamily: 'Spartan MB',
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Image(
                        image: index == 0
                            ? AssetImage(favcoins[index]['image'])
                            : NetworkImage(favcoins[index]['imageUrl'])
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: 500,
                      child: Center(
                        child: Text(
                          index == 0
                              ? favcoins[index]["name"]
                              : '\$ ${favcoins[index]['coinPrice'].toString()}',
                          style: TextStyle(
                            color: index == 0
                                ? kWhite
                                : favcoins[index]['coinPriceChange'] < 0
                                    ? kRed
                                    : kGreen,
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kBlack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
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
