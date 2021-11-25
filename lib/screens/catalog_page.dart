import 'dart:async';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';

class CatalogPage extends StatefulWidget {
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<CatalogPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'CATALOG KIRBY',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
