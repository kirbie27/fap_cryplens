import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';
import 'dart:math' as math;

final List<Map> coins =
    List.generate(2, (index) => {"id": index, "name": "Coin $index"}).toList();

class CoinPage extends StatefulWidget {
  const CoinPage({Key? key}) : super(key: key);

  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CoinContent(),
        ),
      ),
    );
  }
}

class CoinContent extends StatefulWidget {
  const CoinContent({Key? key}) : super(key: key);

  @override
  _CoinContentState createState() => _CoinContentState();
}

class _CoinContentState extends State<CoinContent> {
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
                    "Price",
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
                    "Trust Score",
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
              "Volume",
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
              "Market Cap",
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
          height: 15,
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
