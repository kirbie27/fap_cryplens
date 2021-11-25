import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/introduction.dart';
import 'package:cryplens/screens/pouch_page.dart';
import 'package:cryplens/screens/catalog_page.dart';
import 'package:cryplens/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cryplens/screens/start_page.dart';
import 'package:cryplens/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cryplens/loadapp.dart';

void main() {
  runApp(CryptoLens());
}

class CryptoLens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Lato'),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: kBlack,
      ),
      initialRoute: '/loader',
      routes: {
        '/introduction': (context) => hello(), //showcasing features
        '/getname': (context) => introPage(), //getting the name
        '/welcome': (context) => welcomePage(), //testing the input name
        '/home': (context) => NavigatorPage(),
        '/loader': (context) => Load(),
      },
    );
  }
}
