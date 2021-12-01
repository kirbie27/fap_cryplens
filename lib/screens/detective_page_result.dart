import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/whitepaper_view.dart';
import 'package:cryplens/services/models/whitepaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cryplens/services/models/detective_crypto_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cryplens/screens/navigation.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({required this.response, required this.whitepaper});

  //variables that contain the data from the api of the whitepaper and coingecko.
  WhitePaper whitepaper;
  CoinResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(response.name.toUpperCase(), style: detectiveCryptoText),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              NavigatorPage.fromSearch = true;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  NavigatorPage.routeName, (route) => false,
                  arguments: {'index': 2});
            },
            icon: Icon(
              Icons.close,
              color: kWhite,
            ),
          ),
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
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(response.img),
                                height: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                response.symbol.toUpperCase(),
                                style: TextStyle(
                                  color: kWhite,
                                  fontFamily: 'Spartan MB',
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              response.coingeckoRank.toString(),
                              style: TextStyle(
                                color: kYellow,
                                fontFamily: 'Spartan MB',
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
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
                      ],
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              response.liquidityScore.toString(),
                              style: TextStyle(
                                color: kYellow,
                                fontFamily: 'Spartan MB',
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
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
                      ],
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              response.developerScore.toString(),
                              style: TextStyle(
                                color: kYellow,
                                fontFamily: 'Spartan MB',
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
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
                      ],
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              response.communityScore.toString(),
                              style: TextStyle(
                                color: kYellow,
                                fontFamily: 'Spartan MB',
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "Community Score",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              response.coingeckoScore.toString(),
                              style: TextStyle(
                                color: kYellow,
                                fontFamily: 'Spartan MB',
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "Coingecko Score",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            xValueMapper: (VotingData exp, _) => exp.voteString,
                            yValueMapper: (VotingData exp, _) =>
                                exp.voteUpPercentage,
                            color: kGreen,
                          ),
                          StackedBar100Series<VotingData, String>(
                            dataSource: _chartData,
                            xValueMapper: (VotingData exp, _) => exp.voteString,
                            yValueMapper: (VotingData exp, _) =>
                                exp.voteDownPercentage,
                            color: kRed,
                          ),
                        ],
                        primaryXAxis: CategoryAxis(
                          isVisible: false,
                        ),
                        primaryYAxis: NumericAxis(),
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
            child: GestureDetector(
              onTap: () {
                if (whitepaper.name != "BLANK") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WhitepaperView(whitepaperURL: whitepaper.url)));
                }
              },
              //This container contains the apis image network which serves as the background of the news tile
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: kGray,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1623276527153-fa38c1616b05?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          kGray.withOpacity(0.3), BlendMode.dstATop)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      whitepaper.name == "BLANK"
                          ? "Whitepaper Unavailable"
                          : "Whitepaper Available",
                      style: TextStyle(
                        color: kWhite,
                        fontFamily: 'Spartan MB',
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
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
