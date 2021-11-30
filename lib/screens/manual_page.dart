import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/widgets/ManualTable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualPage extends StatefulWidget {
  ManualPage({required Key key}) : super(key: key);
  @override
  ManualPageState createState() => ManualPageState();
}

class ManualPageState extends State<ManualPage> {
  Future<void> ManualInstructions() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'About Manual',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              'Here you can see a list of Crypto Currencies:'
              '\n1. skdfhsjkdfhkshfkdshfksdhjkfhsd'
              '\n2. akdhaskjdhjkashdkashdkashdjkas',
              textAlign: TextAlign.justify,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                color: kGreen,
                child: Text('OK',
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kGray,
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
