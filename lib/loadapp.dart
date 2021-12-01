import 'package:cryplens/constants.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cryplens/user.dart';

class Load extends StatefulWidget {
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  bool loading = true;
  bool gettingCrypto = false;
  late Future loader;
  bool firstTime = true;

  //initializes the loading screen, and calls the function
  //that gets the shared preferences data and the crypto data on load
  void initState() {
    super.initState();
    loading = true;
    gettingCrypto = false;
    loader = getData();
  }

  //clears the preferences for debugging purposes
  setPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  getData() async {
    User user = User();
    final prefs = await SharedPreferences.getInstance();

    //checks if there is already an existing name in the preferences
    //if there is then it means that it is not the first log in of the user
    bool nameExists = await prefs.containsKey('name');
    if (nameExists) {
      user.setName(await prefs.getString('name') ?? "Agent");
    }
    //adds a short delay to ensure that data is retrieved
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
      gettingCrypto = true;
    });

    //loads the initial crypto data
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.getCoinsTableAtLoad();
    setState(() {
      if (nameExists)
        firstTime = false;
      else
        firstTime = true;
      loader = Future.value('done');
      gettingCrypto = false;
    });
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
                      future: loader,
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (!loading && !gettingCrypto) {
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
                                  if (firstTime == true) {
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
                        } else if (loading && !gettingCrypto) {
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
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Getting Crypto Data...',
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
