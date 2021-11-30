import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'detective_crypto_models.dart';
import 'detective_crypto_data_service.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(
      {required this.name, required this.id, required this.liquidityScore, required this.developerScore,
        required this.communityScore, required this.coingeckoScore, required this.coingeckoRank, required this.symbol,
        required this.sentimentVoteUpPercentage, required this.sentimentVoteDownPercentage});

  final String name;
  final String id;
  final double liquidityScore;
  final double developerScore;
  final double communityScore;
  final double coingeckoScore;
  final int coingeckoRank;
  final String symbol;
  final double sentimentVoteUpPercentage;
  final double sentimentVoteDownPercentage;

  @override
  Widget build(BuildContext context) {

    final _cityTextController = TextEditingController();
    final _dataService = DataService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detective Crypto', style: detectiveCryptoText),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                      id.toUpperCase(),
                      style: detectiveCryptoText,
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                liquidityScore.toString(),
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                developerScore.toString(),
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                communityScore.toString(),
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                coingeckoScore.toString(),
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                coingeckoRank.toString(),
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                symbol,
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                sentimentVoteUpPercentage.toString() + '%',
                style: detectiveCryptoText,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                sentimentVoteDownPercentage.toString() + '%',
                style: detectiveCryptoText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
