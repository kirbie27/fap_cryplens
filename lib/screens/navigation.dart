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
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorPage> {
  int _currentIndex = 0;

  void onTabTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  final pages = [
    CatalogPage(),
    PouchPage(),
    DetectiveCryptoPage1(),
    NewsPage(),
    checker(label: 'MANUAL')
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavBar(onTap: onTabTapped),
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
