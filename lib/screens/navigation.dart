import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/catalog_page.dart';
import 'package:cryplens/screens/pouch_page.dart';
import 'package:cryplens/screens/news_page.dart';
import 'package:cryplens/screens/manual_page.dart';
import 'package:cryplens/screens/detective_page.dart';

class NavigatorPage extends StatefulWidget {
  static const routeName = '/home';
  static bool fromSearch = false;
  NavigatorPage();
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorPage> {
  final GlobalKey<CatalogPageState> catalogKey = GlobalKey();
  final GlobalKey<PouchPageState> pouchKey = GlobalKey();
  final GlobalKey<DetectiveCryptoPage1State> detectiveKey = GlobalKey();
  final GlobalKey<NewsPageState> newsKey = GlobalKey();
  final GlobalKey<ManualPageState> manualKey = GlobalKey();

  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  void onTabTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  goToSearch(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final titles = [
    'Coin Catalog',
    'Coin Pouch',
    'Detective Luna',
    'CryptoPages',
    'Manual'
  ];

  Widget build(BuildContext context) {
    dynamic searchIndex = ModalRoute.of(context)!.settings.arguments;
    if (NavigatorPage.fromSearch == true && searchIndex != null) {
      _currentIndex = searchIndex['index'];
      NavigatorPage.fromSearch = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //the conditions are used to inform the application which
              //informatoin popup should be used. The "GlobalKey" was used as the popups are
              //functions inside some child widgets of the Navigation page.
              if (_currentIndex == 0 && catalogKey.currentState != null)
                catalogKey.currentState!.CatalogInstructions();
              else if (_currentIndex == 1 && pouchKey.currentState != null) {
                pouchKey.currentState!.PouchInstructions();
              } else if (_currentIndex == 2 &&
                  detectiveKey.currentState != null) {
                detectiveKey.currentState!.DetectiveInstructions();
              } else if (_currentIndex == 3 && newsKey.currentState != null) {
                newsKey.currentState!.NewsInstructions();
              } else if (_currentIndex == 4 && manualKey.currentState != null) {
                manualKey.currentState!.ManualInstructions();
              }
            },
            child: Icon(
              Icons.info_outline,
              color: kWhite,
            ),
          ),
        ],
        backgroundColor: kNavyBlue,
      ),
      body: _currentIndex == 0
          ? CatalogPage(key: catalogKey)
          : _currentIndex == 1
              ? PouchPage(key: pouchKey)
              : _currentIndex == 2
                  ? DetectiveCryptoPage1(key: detectiveKey)
                  : _currentIndex == 3
                      ? NewsPage(key: newsKey)
                      : ManualPage(key: manualKey),
      bottomNavigationBar:
          NavBar(selectedIndex: _currentIndex, onTap: onTabTapped),
    );
  }
}
