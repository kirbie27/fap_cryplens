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

    return Scaffold(
      appBar: AppBar(
        title: Text('Detective Crypto', style: detectiveCryptoText),
      ),
      body: Padding(
            padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                        id.toUpperCase(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        liquidityScore.toString(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        developerScore.toString(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        communityScore.toString(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        coingeckoScore.toString(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        coingeckoRank.toString(),
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        symbol,
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        sentimentVoteUpPercentage.toString() + '%',
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                    Text(
                        sentimentVoteDownPercentage.toString() + '%',
                        style: detectiveCryptoText,
                        textAlign: TextAlign.left),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
