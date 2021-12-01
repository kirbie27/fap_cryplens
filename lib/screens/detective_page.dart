import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cryplens/services/models/detective_crypto_models.dart';
import 'package:cryplens/services/detective_crypto_data_service.dart';
import 'detective_page_result.dart';
import 'package:cryplens/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetectiveCryptoPage1 extends StatefulWidget {
  DetectiveCryptoPage1({required Key key}) : super(key: key);
  @override
  DetectiveCryptoPage1State createState() => DetectiveCryptoPage1State();
}

int toggle = 1;

class DetectiveCryptoPage1State extends State<DetectiveCryptoPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  TextEditingController _textEditingController = TextEditingController();

  final _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

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
              '\n\n2. You can search for a specific coin using the search bar, and you can tap on the search'
              'button or simply press search on the keypad, and to be redirected to another page if you'
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
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: detectiveCryptoPadding,
            child: Text(
                'Whisper the token to me, and I\'ll check if it\'s a credible crypto ${User.name}!',
                textAlign: TextAlign.center,
                style: detectiveCryptoText),
          ),
          Container(
            //color: Colors.green,
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
                    cursorColor: Colors.lightGreenAccent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(left: 55.0),
                      labelText: 'Enter coin code...',
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
                      borderRadius: BorderRadius.circular(30.0), color: kGray),
                ),
                Material(
                  color: kGray,
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
            child: Text('Things to consider:',
                style: detectiveCryptoText, textAlign: TextAlign.left),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text('Whitepaper',
                      style: detectiveCryptoText, textAlign: TextAlign.left),
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
                  child: Text('Liquidity',
                      style: detectiveCryptoText, textAlign: TextAlign.left),
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
                  child: Text('Volume',
                      style: detectiveCryptoText, textAlign: TextAlign.left),
                ),
                detectiveCryptoIcon
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 30.0, top: 40.0, right: 30.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text('Social Media \nEngagement',
                      maxLines: 3,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: detectiveCryptoText,
                      textAlign: TextAlign.left),
                ),
                detectiveCryptoIcon
              ],
            ),
          ),
        ],
      ),
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
              'The coin/token you are looking for is missing sorry, try again.',
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
    final response = _dataService.fromCoinGecko;
    if (response != null) {
      // print(_cityTextController.text);
      print('Coin Name: ' + response.id);
      print('Liquidity Score: ' + response.liquidityScore.toString());
      print('Developer Score: ' + response.developerScore.toString());
      print('Community Score: ' + response.communityScore.toString());
      print('Coingecko Score: ' + response.coingeckoScore.toString());
      print('Coingecko Rank: ' + response.coingeckoRank.toString());
      print('Symbol: ' + response.symbol);
      print('Vote Up Percentage: ' +
          response.sentimentVoteUpPercentage.toString());
      print('Vote Down Percentage: ' +
          response.sentimentVoteDownPercentage.toString());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            response: response,
          ),
        ),
      );
    } else {
      invalidSearch();
    }
  }
}
