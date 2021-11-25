import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cryplens/constants.dart';

class welcomePage extends StatefulWidget {
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcomePage> {
  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    return await prefs.getString('name') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FutureBuilder(
                      future: getName(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          return Text(
                            'Welcome to CrypLens, Agent ${snap.data}!',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Spartan MB',
                              fontSize: 35.0,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Container(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: 180,
                        child: ElevatedButton(
                          child: Text('GET STARTED'.toUpperCase(),
                              style: TextStyle(fontSize: 18)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                              Navigator.pushReplacementNamed(context, '/home');
                            });
                          },
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
