import 'package:cryplens/services/crypto.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:cryplens/search.dart';
import 'package:cryplens/screens/navigation.dart';
import 'package:cryplens/services/crypto.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              coin['imageUrl'],
              height: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
                '${coin['coinName']} (${coin['coinSymbol'].toString().toUpperCase()})'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (coin['favCoinID'] != null) //nasa pouch page nanggaling
              {
                NavigatorPage.fromSearch = true;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    NavigatorPage.routeName, (route) => false,
                    arguments: {'index': 1});
              } else {
                NavigatorPage.fromSearch = true;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    NavigatorPage.routeName, (route) => false,
                    arguments: {'index': 0});
              }
            },
            child: Icon(
              Icons.close,
              color: kWhite,
            ),
          ),
        ],
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
  CoinContentState createState() => CoinContentState(coin: coin);
}

late List coinChart;

class CoinContentState extends State<CoinContent> {
  CoinContentState({required this.coin});
  Map coin;
  bool favorite = false;
  Search search = Search();
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future loader;
  bool loading = true;

  @override
  /*
  void setState(VoidCallback fn) {
   range = dats na gusto mo;
   loading = true;
  }
  getData();
  */

  void initState() {
    super.initState();
    print('nasa init state!');
    print('test');
    loading = true;
    loader = getData();
  }

  getData() async {
    final crypto = Crypto();
    final holder = await dbHelper.searchFavCoin(coin['coinID']);
    await crypto.getCryptoChart(coin['coinID'], 1.toString());
    print(holder);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      if (!holder.isEmpty) {
        favorite = true;
      } else {
        favorite = false;
      }
      coinChart = crypto.chartOHLC;
      print(coinChart);
      loader = Future.value(holder);
      loading = false;
    });
    print(coinChart);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loader,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (!loading) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            print('Search: ${coin['coinName']}');
                            Search search = Search();
                            search.setSearch(coin['coinName']);
                            NavigatorPage.fromSearch = true;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                NavigatorPage.routeName, (route) => false,
                                arguments: {'index': 3});
                          },
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            print(favorite);
                            if (favorite) {
                              dbHelper.deleteFavCoin(coin['coinID']);
                            } else {
                              dbHelper
                                  .insertFavCoin({'favCoinID': coin['coinID']});
                            }
                            setState(() {
                              loading = true;
                            });
                            getData();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              !favorite ? 'Add to Pouch' : 'Added',
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 20.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: !favorite ? kGray : kBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                  child: Center(
                    child: Container(
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                          child: Graph(),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
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
          } else {
            return Container(alignment: Alignment.center, child: Loading);
          }
        });
  }
}

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      trackballBehavior: _trackballBehavior,
      series: <CandleSeries>[
        CandleSeries<ChartSampleData, DateTime>(
            dataSource: _chartData,
            xValueMapper: (ChartSampleData coinChartData, _) =>
                coinChartData.time,
            lowValueMapper: (ChartSampleData coinChartData, _) =>
                coinChartData.low,
            highValueMapper: (ChartSampleData coinChartData, _) =>
                coinChartData.high,
            openValueMapper: (ChartSampleData coinChartData, _) =>
                coinChartData.open,
            closeValueMapper: (ChartSampleData coinChartData, _) =>
                coinChartData.close),
      ],
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.Hm(),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    );
  }

  List<ChartSampleData> getChartData() {
    List<ChartSampleData> chart = [];
    for (int i = 0; i < coinChart.length; i++) {
      chart.add(
        ChartSampleData(
          time: DateTime.fromMillisecondsSinceEpoch(coinChart[i]['unix']),
          open: coinChart[i]['O'],
          high: coinChart[i]['H'],
          low: coinChart[i]['L'],
          close: coinChart[i]['C'],
        ),
      );
    }
    return chart;
  }
}

class ChartSampleData {
  ChartSampleData({this.time, this.open, this.close, this.low, this.high});
  final DateTime? time;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
}
