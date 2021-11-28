import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';
import 'dart:math' as math;

class CoinPage extends StatefulWidget {
  CoinPage({required this.coin});
  Map coin;
  @override
  _CoinPageState createState() => _CoinPageState(coin: coin);
}

class _CoinPageState extends State<CoinPage> {
  _CoinPageState({required this.coin});
  Map coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${coin['coinName']}'),
        backgroundColor: kGray,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CoinContent(coin: coin),
        ),
      ),
    );
  }
}

class CoinContent extends StatefulWidget {
  CoinContent({required this.coin});
  Map coin;
  @override
  _CoinContentState createState() => _CoinContentState(coin: coin);
}

class _CoinContentState extends State<CoinContent> {
  _CoinContentState({required this.coin});
  Map coin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "See Related News",
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Spartan MB',
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Add to Pouch",
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Spartan MB',
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    coin['coinPrice'].toString(),
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Spartan MB',
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    coin['coinMarketCapRank'].toString(),
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Spartan MB',
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              coin['coinTotalVolume'].toString(),
              style: TextStyle(
                color: kWhite,
                fontFamily: 'Spartan MB',
                fontSize: 20.0,
              ),
            ),
            decoration: BoxDecoration(
              color: kGray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              coin['coinMarketCap'].toString(),
              style: TextStyle(
                color: kWhite,
                fontFamily: 'Spartan MB',
                fontSize: 20.0,
              ),
            ),
            decoration: BoxDecoration(
              color: kGray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 7,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Graph",
              style: TextStyle(
                color: kWhite,
                fontFamily: 'Spartan MB',
                fontSize: 30.0,
              ),
            ),
            decoration: BoxDecoration(
              color: kGray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Powered by Coingecko",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontFamily: 'Spartan MB',
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
