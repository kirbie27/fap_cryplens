import 'package:cryplens/services/crypto.dart';
import 'package:cryplens/services/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:cryplens/search.dart';
import 'package:cryplens/screens/navigation.dart';

String title = "Hourly Chart";
DateFormat date = DateFormat.Hm();

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
          IconButton(
            onPressed: () {
              if (coin['favCoinID'] != null) //From pouch page
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
            icon: Icon(
              Icons.close,
              color: kWhite,
            ),
          ),
        ],
        backgroundColor: kNavyBlue,
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
late int range = 1;

class CoinContentState extends State<CoinContent> {
  CoinContentState({required this.coin});
  Map coin;
  bool favorite = false;
  Search search = Search();
  var coinPriceColor;
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future loader;
  bool loading = true;
  NumberFormat numberFormat = NumberFormat();
  List<int> rangeList = [1, 7, 90];
  List<String> titleList = ["Hourly Chart", "Daily Chart", "Monthly Chart"];
  List<DateFormat> dateList = [
    DateFormat.Hm(),
    DateFormat.d(),
    DateFormat.MMM()
  ];
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loading = true;
    loader = getData();
  }

  //Gets information from the api and stores it in a data
  getData() async {
    final crypto = Crypto();
    final holder = await dbHelper.searchFavCoin(coin['coinID']);
    await crypto.getCryptoChart(coin['coinID'], range.toString());
    await Future.delayed(Duration(seconds: 1));
    //Changes the button if the user adds the coin data to the pouch page
    setState(() {
      if (!holder.isEmpty) {
        favorite = true;
      } else {
        favorite = false;
      }
      coinChart = crypto.chartOHLC;
      loader = Future.value(holder);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Method to change the color of the price in case they increase or decrease
    if (coin['coinPriceChange'] > 0) {
      coinPriceColor = kGreen;
    } else if (coin['coinPriceChange'] < 0) {
      coinPriceColor = kRed;
    } else {
      coinPriceColor = kWhite;
    }

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
                              maxLines: 2,
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 20.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: kNavyBlue,
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
                              maxLines: 2,
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 20.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: !favorite ? kNavyBlue : kBlueGreen,
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
                            "\$ " + coin['coinPrice'].toString(),
                            style: TextStyle(
                              color: coinPriceColor,
                              fontFamily: 'Spartan MB',
                              fontSize: 20.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: kNavyBlue,
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
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Rank\n",
                              style: TextStyle(
                                  color: kWhite,
                                  fontFamily: 'Spartan MB',
                                  fontSize: 20),
                              children: <TextSpan>[
                                TextSpan(
                                    text: coin['coinMarketCapRank'].toString(),
                                    style: TextStyle(color: kBlueGreen)),
                              ],
                            ),
                          ),
                          // child: Text(
                          //   'Market Cap Rank\n' +
                          //       coin['coinMarketCapRank'].toString(),
                          //   style: TextStyle(
                          //     color: kBlueGreen,
                          //     fontFamily: 'Spartan MB',
                          //     fontSize: 20.0,
                          //   ),
                          // ),
                          decoration: BoxDecoration(
                            color: kNavyBlue,
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
                    child: RichText(
                      text: TextSpan(
                        text: "Total Volume: ",
                        style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\$ ' +
                                  numberFormat.format(coin['coinTotalVolume']),
                              style: TextStyle(color: kBlueGreen)),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kNavyBlue,
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
                    child: RichText(
                      text: TextSpan(
                        text: "Market Cap: ",
                        style: TextStyle(
                            color: kWhite,
                            fontFamily: 'Spartan MB',
                            fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\$ ' +
                                  numberFormat.format(coin['coinMarketCap']),
                              style: TextStyle(color: kBlueGreen)),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kNavyBlue,
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
                    child: GestureDetector(
                      onTap: () {
                        if (counter == 0) {
                          range = rangeList[counter + 1];
                          title = titleList[counter + 1];
                          date = dateList[counter + 1];
                          counter++;
                        } else if (counter == 1) {
                          range = rangeList[counter + 1];
                          title = titleList[counter + 1];
                          date = dateList[counter + 1];
                          counter++;
                        } else if (counter == 2) {
                          range = rangeList[counter - 2];
                          title = titleList[counter - 2];
                          date = dateList[counter - 2];
                          counter = 0;
                        } else {
                          print("tapped but no output"); //debug print
                        }
                        setState(() {
                          loading = true;
                        });
                        getData();
                      },
                      child: Container(
                        child: Graph(),
                        decoration: BoxDecoration(
                          color: kNavyBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
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
      title: ChartTitle(
        text: title,
        textStyle: TextStyle(
          color: kWhite,
          fontFamily: 'Spartan MB',
          fontSize: 15.0,
        ),
      ),
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
        dateFormat: date,
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
