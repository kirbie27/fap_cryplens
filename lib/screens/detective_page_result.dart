import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/services/models/detective_crypto_models.dart';
import 'package:cryplens/services/detective_crypto_data_service.dart';

class ResultsPage extends StatelessWidget {
  CoinResponse response;
  ResultsPage({required this.response});

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
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }
}
