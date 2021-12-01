import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/navigation.dart';
import 'package:cryplens/services/models/whitepaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/services/models/detective_crypto_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({required this.response, required this.whitepaper});

  //variables that contain the data from the api of the whitepaper and coingecko.
  WhitePaper whitepaper;
  CoinResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detective Crypto', style: detectiveCryptoText),
        actions: [
          IconButton(
              onPressed: () {
                NavigatorPage.fromSearch = true;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    NavigatorPage.routeName, (route) => false,
                    arguments: {'index': 2});
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: ResultsPageContent(
        response: response,
        whitepaper: whitepaper,
      ),
    );
  }
}

class ResultsPageContent extends StatefulWidget {
  ResultsPageContent({required this.response, required this.whitepaper});
  final CoinResponse response;
  WhitePaper whitepaper;

  @override
  _ResultsPageContentState createState() =>
      _ResultsPageContentState(response: response, whitepaper: whitepaper);
}

class _ResultsPageContentState extends State<ResultsPageContent> {
  _ResultsPageContentState({required this.response, required this.whitepaper});
  WhitePaper whitepaper;
  CoinResponse response;
  late List<VotingData> _chartData;

  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Flexible(
                                  child: Text(
                                    response.name,
                                    style: TextStyle(
                                      color: kWhite,
                                      fontFamily: 'Spartan MB',
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: NetworkImage(response.img),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Flexible(
                                        child: Text(
                                          response.symbol.toUpperCase(),
                                          style: TextStyle(
                                            color: kWhite,
                                            fontFamily: 'Spartan MB',
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  response.coingeckoRank.toString(),
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  "Coingecko Rank",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  response.liquidityScore.toString(),
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  "Liquidity Score",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  response.developerScore.toString(),
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  "Developer Score",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  response.communityScore.toString(),
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  "Community Score",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  response.coingeckoScore.toString(),
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Flexible(
                                child: Text(
                                  "Coingecko Score",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontFamily: 'Spartan MB',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Center(
                        child: SfCartesianChart(
                          title: ChartTitle(
                            text: "Approval Rating",
                            textStyle: TextStyle(
                              color: kWhite,
                              fontFamily: 'Spartan MB',
                              fontSize: 15.0,
                            ),
                          ),
                          plotAreaBorderColor: Colors.transparent,
                          series: <ChartSeries>[
                            StackedBar100Series<VotingData, String>(
                              dataSource: _chartData,
                              xValueMapper: (VotingData exp, _) =>
                                  exp.voteString,
                              yValueMapper: (VotingData exp, _) =>
                                  exp.voteUpPercentage,
                            ),
                            StackedBar100Series<VotingData, String>(
                              dataSource: _chartData,
                              xValueMapper: (VotingData exp, _) =>
                                  exp.voteString,
                              yValueMapper: (VotingData exp, _) =>
                                  exp.voteDownPercentage,
                            ),
                          ],
                          primaryXAxis: CategoryAxis(
                            isVisible: false,
                          ),
                          primaryYAxis: NumericAxis(),
                        ),
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
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Flexible(
                        child: Text(
                          "1",
                          style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 30.0,
                          ),
                        ),
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
        ],
      ),
    );
  }

  List<VotingData> getChartData() {
    final List<VotingData> chartData = [
      VotingData("Approval Rating", response.sentimentVoteUpPercentage,
          response.sentimentVoteDownPercentage),
    ];
    return chartData;
  }
}

class VotingData {
  VotingData(this.voteString, this.voteUpPercentage, this.voteDownPercentage);
  final String voteString;
  final num voteUpPercentage;
  final num voteDownPercentage;
}
