import 'dart:async';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/catalog_page.dart';
import 'package:cryplens/screens/pouch_page.dart';
import 'package:cryplens/screens/news_page.dart';
import 'package:cryplens/screens/manual_page.dart';
import 'package:cryplens/screens/detective_page.dart';

class NavigatorPage extends StatefulWidget {
  NavigatorPage();
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorPage> {
  int _currentIndex = 0;

  void onTabTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  final titles = [
    'Coin Catalog',
    'Coin Pouch',
    'Detective Crypto',
    'CryptoPages',
    'Manual'
  ];

  final pages = [
    CatalogPage(),
    PouchPage(),
    DetectiveCryptoPage1(),
    NewsPage(),
    ManualPage()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        backgroundColor: kGray,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar:
          NavBar(selectedIndex: _currentIndex, onTap: onTabTapped),
    );
  }
}

class checker extends StatelessWidget {
  checker({required this.label});
  String label;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
