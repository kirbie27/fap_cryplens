import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:cryplens/services/detective_crypto_data_service.dart';
import 'detective_page_result.dart';
import 'package:cryplens/user.dart';

class DetectiveCryptoPage1 extends StatefulWidget {
  DetectiveCryptoPage1({required Key key}) : super(key: key);
  @override
  DetectiveCryptoPage1State createState() => DetectiveCryptoPage1State();
}

int toggle = 1;

class DetectiveCryptoPage1State extends State<DetectiveCryptoPage1>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();

  final _dataService = DataService();

  @override
  Future<void> DetectiveInstructions() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'How to Use Detective Luna',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              '1. The Detective Luna retrieves a coin or token you want to check, and returns information about them that you can use '
              'for your checklist.'
              '\n\n2. You can search for a specific coin using the search bar, and you can tap on the search '
              'button or simply press search on the keypad, and to be redirected to another page if you '
              'searched a coin that is in the connected apis.',
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 100,
              child: Text(
                  'Whisper the token to me, and I\'ll check if it\'s a credible crypto ${User.name}!',
                  textAlign: TextAlign.center,
                  style: detectiveCryptoText),
            ),
            //Search bar widget
            Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 500.0,
                    alignment: Alignment.center,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          _textEditingController.clear();
                        });
                        _search(value);
                      },
                      style: TextStyle(color: kWhite),
                      controller: _textEditingController,
                      cursorWidth: 2.0,
                      cursorColor: kWhite,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.only(left: 55.0),
                        labelText: 'Enter coin name...',
                        labelStyle: TextStyle(
                          color: Colors.white24,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: kNavyBlue),
                  ),
                  Material(
                    color: kNavyBlue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: IconButton(
                      // splashRadius: 19.0,
                      icon: Icon(
                        Icons.search,
                        color: kWhite,
                      ),
                      onPressed: () {
                        setState(() {
                          _textEditingController.clear();
                        });
                        _search(_textEditingController.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text('Coin/Token Checklist',
                  style: detectiveCryptoText, textAlign: TextAlign.left),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Whitepaper',
                            style: detectiveCryptoText,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                          child: Text(
                            'Contains the technical information '
                            'about a cryptocurrency project which you can check'
                            ' to gain more knowledge about a certain token or coin.',
                            style: TextStyle(color: kWhite),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  ),
                  detectiveCryptoIcon
                ],
              ),
            ),
            Padding(
              padding: detectiveCryptoPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Coin Rating',
                            style: detectiveCryptoText,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                          child: Text(
                            'Checking the rating of crypto currencies can be a good assessment when looking'
                            ' for a coin or token to invest in. Some websites such as Coin Gecko give ratings to coins or tokens '
                            'which can be a good baseline for judgement.',
                            style: TextStyle(color: kWhite),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  ),
                  detectiveCryptoIcon
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> invalidSearch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'INVALID SEARCH!',
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Text(
              'Sorry the coin that you are looking for is missing. Please try again.',
              textAlign: TextAlign.center,
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
                color: kRed,
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

  void _search(String search) async {
    //Asynchronous code lets us fetch data over a network
    //await provides a declarative way to define asynchronous functions and use their result
    await _dataService.getCoin(search);
    final coinData = _dataService.fromCoinGecko;
    final whitePaper = _dataService.coinWhitePaper;
    if (coinData != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              response: coinData,
              whitepaper: whitePaper,
            ),
          ),
          (route) => false);
    } else {
      invalidSearch();
    }
  }
}
