import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/user.dart';

class introPage extends StatefulWidget {
  _introState createState() => _introState();
}

class _introState extends State<introPage> {
  final nameController = TextEditingController();
  void clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  _introState() {
    print('Time to get the name!');
  }
  late String input;
  void setName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    User user = User();
    user.setName(await prefs.getString('name') ?? 'C');
    setState(() {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  String answer = 'no';

  Future<void> _confirmInput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'CONFIRM YOUR NAME',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              'Agent ${input}, correct?',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Icon(FontAwesomeIcons.smile),
              onPressed: () {
                setState(() {
                  answer = 'yes';
                  Navigator.of(context).pop();
                  setName(input);
                });
              },
            ),
            TextButton(
              child: Icon(FontAwesomeIcons.sadCry),
              onPressed: () {
                setState(() {
                  answer = 'no';
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _blankInput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'INVALID INPUT!',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              'Please enter your agent name.',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Icon(FontAwesomeIcons.thumbsUp),
              onPressed: () {
                setState(() {
                  answer = 'no';
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  FocusNode fn = FocusNode();

  void dispose() {
    fn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'What should I call you Agent?',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Spartan MB',
                        fontSize: 28.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 30, 60, 0),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        input = value;
                        if (input != '')
                          _confirmInput();
                        else
                          _blankInput();
                      },
                      cursorColor: kBlue,
                      focusNode: fn,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: nameController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kBlue, width: 1),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        hintText: 'Enter your name here',
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      ),
                    ),
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
                      child: Text('Submit'.toUpperCase(),
                          style: TextStyle(fontSize: 18)),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kGreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      onPressed: () {
                        input = nameController.text;
                        if (input != '')
                          _confirmInput();
                        else
                          _blankInput();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
