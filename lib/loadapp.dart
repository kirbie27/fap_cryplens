import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/introduction.dart';
import 'package:cryplens/screens/pouch_page.dart';
import 'package:cryplens/screens/catalog_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cryplens/screens/start_page.dart';
import 'package:cryplens/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cryplens/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(Load());
}

class Load extends StatefulWidget {
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  Future<bool> getName() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 5));
    User user = User();
    user.setName(await prefs.getString('name') ?? "Agent");
    return await prefs.containsKey('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: getName(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          bool launched = snap.data;
                          return Container(
                            height: 70,
                            width: 220,
                            child: ElevatedButton(
                              child: Text('LAUNCH CRYPLENS'.toUpperCase(),
                                  style: TextStyle(fontSize: 18)),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(kBlue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (launched == false) {
                                    Navigator.pushReplacementNamed(
                                        context, '/introduction');
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  }
                                });
                              },
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Checking if Data Exists...',
                                    style: kMessageTextStyle),
                                SizedBox(height: 50),
                                Container(
                                    height: 80, width: 80, child: startupLoad),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
