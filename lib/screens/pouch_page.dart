import 'package:cryplens/screens/coin_page.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/user.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:cryplens/screens/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//initial content of the favcoins list, as the first
//item in the favcoins list should not be from the api, but a widget that redirects the user to
//the catalog page.
late List<dynamic> favcoins = [
  {'id': 0, 'name': '+', 'title': '', 'image': 'assets/images/AddIcon.png'}
];

class PouchPage extends StatefulWidget {
  PouchPage({required Key key}) : super(key: key);
  @override
  PouchPageState createState() => PouchPageState();
}

//flag variable used to inform the app if the spinkit for loading should be displayed,
//to allow data to be retrieved from the database.
bool loading = true;

class PouchPageState extends State<PouchPage> {
  User user = User();
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future loader;

  //loads the data so that the futurebuilder can display the loading
  void initState() {
    super.initState();
    loading = true;
    loader = getData();
  }

  //popup for the pouch to inform the user on how to use the application.
  Future<void> PouchInstructions() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'How to use the Pouch',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              '1. The pouch contains your favorite coins for easy access.'
              '\n\n2. You can tap the add coin button to be redirected to the catalog page '
              'where you can find more coins to add to your pouch.'
              '\n\n3. After adding some coins to your pouch, the coins will appear on this page, and you can tap on them '
              'to go to their specific coin page.'
              '\n\n4. You can also remove coins from your pouch by going to their coin page and tapping on the added button',
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

  //function that gets the data from the database.
  getData() async {
    final holder = await dbHelper.getFavCoinsTable();
    print('hello pouch');
    setState(() {
      //initially sets the first item on the list.
      favcoins = [
        {
          'id': 0,
          'name': 'Add Coin',
          'title': '',
          'image': 'assets/images/AddIcon.png'
        }
      ];
      //adds all the coins retrieved from the databae to the favcoins list so that it can be
      //generated later.
      favcoins.addAll(holder);
      print(holder);

      //sets a dummy future value to the loader to make the futurebuilder work.
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
                  'Hi ${User.name}, I listed here the contents of your pouch',
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
