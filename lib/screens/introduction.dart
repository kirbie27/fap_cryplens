import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/start_page.dart';

class hello extends StatefulWidget {
  _helloState createState() => _helloState();
}

class _helloState extends State<hello> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (count < 3)
                count = count + 1;
              else
                Navigator.pushReplacementNamed(context, '/getname');
            });
          },
          child: IndexedStack(
            index: count,
            children: [
              Center(
                child: Image.asset('assets/images/intro1.png'),
              ),
              Center(
                child: Image.asset('assets/images/intro2.png'),
              ),
              Center(
                child: Image.asset('assets/images/intro3.png'),
              ),
              Center(
                child: Image.asset('assets/images/intro4.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
