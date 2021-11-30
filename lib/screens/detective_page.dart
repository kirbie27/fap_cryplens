import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'detective_crypto_models.dart';
import 'detective_crypto_data_service.dart';
import 'detective_page_result.dart';


class DetectiveCryptoPage1 extends StatefulWidget {
  DetectiveCryptoPage1();
  @override
  _DetectiveCryptoPage1State createState() => _DetectiveCryptoPage1State();
}

int toggle = 1;

class _DetectiveCryptoPage1State extends State<DetectiveCryptoPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  TextEditingController _textEditingController = TextEditingController();

  final _cityTextController = TextEditingController();
  final _dataService = DataService();


  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
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
                    'Whisper the token to me, and I\'ll check if it\'s a credible crypto buddy!',
                    textAlign: TextAlign.center,
                    style: detectiveCryptoText),
              ),
              Container(
                height: 100.0,
                width: 250.0,
                alignment: Alignment(-1.0, 0.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 48.0,
                  width: (toggle == 0) ? 48.0 : 250.0,
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: -10.0,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: 6.0,
                        left: 7.0,
                        curve: Curves.easeOut,
                        child: AnimatedOpacity(
                          opacity: (toggle == 0) ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xfff2f3f7),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: AnimatedBuilder(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              builder: (context, widget) {
                                return Transform.rotate(
                                  angle: _con.value * 2.0 * pi,
                                  child: widget,
                                );
                              },
                              animation: _con,
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        left: (toggle == 0) ? 20.0 : 40.0,
                        curve: Curves.easeOut,
                        top: 11.0,
                        child: AnimatedOpacity(
                          opacity: (toggle == 0) ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            height: 23.0,
                            width: 180.0,
                            child: TextField(
                              controller: _cityTextController,
                              cursorRadius: Radius.circular(10.0),
                              cursorWidth: 2.0,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: '',
                                labelStyle: TextStyle(
                                  color: Color(0xff5B5B5B),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        child: IconButton(
                          splashRadius: 19.0,
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 18.0,
                          ),
                          onPressed: () {
                            _search();

                          /*setState(
                                  () {
                                if (toggle == 0) {
                                  toggle = 1;
                                  _con.forward();
                                } else {
                                  toggle = 0;
                                  _textEditingController.clear();
                                  _con.reverse();
                                }
                              },
                            ); */
                          },
                        ),
                      ),
                    ],
                  ),
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
                          style: detectiveCryptoText,
                          textAlign: TextAlign.left),
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
                          style: detectiveCryptoText,
                          textAlign: TextAlign.left),
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
                          style: detectiveCryptoText,
                          textAlign: TextAlign.left),
                    ),
                    detectiveCryptoIcon
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 25.0),
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
  void _search() async { //Asynchronous code lets us fetch data over a network
    //await provides a declarative way to define asynchronous functions and use their result
    final response = await _dataService.getCoin(_cityTextController.text);
    // print(_cityTextController.text);
    print('Coin Name: ' + response.id);
    print('Liquidity Score: ' + response.liquidityScore.toString());
    print('Developer Score: ' + response.developerScore.toString());
    print('Community Score: ' + response.communityScore.toString());
    print('Coingecko Score: ' + response.coingeckoScore.toString());
    print('Coingecko Rank: ' + response.coingeckoRank.toString());
    print('Symbol: ' + response.symbol);
    print('Vote Up Percentage: ' + response.sentimentVoteUpPercentage.toString());
    print('Vote Down Percentage: ' + response.sentimentVoteDownPercentage.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          name: response.name,
          id: response.id,
          liquidityScore: response.liquidityScore,
          developerScore: response.developerScore,
          communityScore: response.communityScore,
          coingeckoScore: response.coingeckoScore,
          coingeckoRank: response.coingeckoRank,
          symbol: response.symbol,
          sentimentVoteUpPercentage: response.sentimentVoteUpPercentage,
          sentimentVoteDownPercentage: response.sentimentVoteDownPercentage,
        ),
      ),
    );
  }
}

