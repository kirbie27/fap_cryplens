import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';

class ManualPage extends StatefulWidget {
  ManualPage();
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual'),
      ),
    );
  }
}