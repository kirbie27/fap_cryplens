import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/widgets/ManualTable.dart';

class ManualPage extends StatefulWidget {
  ManualPage();
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kBlue,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('FEATURES', style: kArticleTitleTextStyle),
            ManualTable()
          ],
        ),
      ),
    );
  }
}



