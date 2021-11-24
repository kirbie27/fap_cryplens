import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';

final NavBarContent navbar = new NavBarContent();

final List<Map> coins =
    List.generate(10, (index) => {"id": index, "name": "Coin $index"}).toList();

class CoinPage extends StatefulWidget {
  const CoinPage({Key? key}) : super(key: key);

  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    void onTabTapped(int i) {
      setState(() {
        _currentIndex = i;
      });
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: kBlack,
        bottomNavigationBar: NavBar(
          onTap: onTabTapped,
        ),
        appBar: AppBar(
          backgroundColor: kGray,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: CoinContent(),
          ),
        ),
      ),
    );
    ;
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
    return Column(children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 4,
        child: Container(
          child: CoinListWidget(),
        ),
      ),
    ]);
  }
}

class CoinListWidget extends StatefulWidget {
  const CoinListWidget({Key? key}) : super(key: key);

  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
