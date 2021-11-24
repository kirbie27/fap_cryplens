import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';

final NavBarContent navbar = new NavBarContent();

//dummy list of coins before api, you may change the number of generated coins
final List<Map> coins =
    List.generate(0, (index) => {"id": index, "name": "Coin $index"}).toList();

class PouchPage extends StatefulWidget {
  const PouchPage({Key? key}) : super(key: key);

  @override
  _PouchPageState createState() => _PouchPageState();
}

class _PouchPageState extends State<PouchPage> {
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
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: PouchContent(),
          ),
        ),
      ),
    );
  }
}

class PouchContent extends StatefulWidget {
  const PouchContent({Key? key}) : super(key: key);

  @override
  _PouchContentState createState() => _PouchContentState();
}

class _PouchContentState extends State<PouchContent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          child: Center(
            child: Text(
              'Hi',
              style: TextStyle(
                color: kWhite,
                fontFamily: 'Spartan MB',
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          child: CoinWidget(),
        ),
      ),
    ]);
  }
}

class CoinWidget extends StatefulWidget {
  const CoinWidget({Key? key}) : super(key: key);

  @override
  _CoinWidgetState createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> {
  @override
  Widget build(BuildContext context) {
    if (coins.length > 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 250,
        ),
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          return CoinContainer(index: index);
        },
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Add new coins from the coin catalog",
          style: TextStyle(
            color: kWhite,
            fontFamily: 'Spartan MB',
            fontSize: 15.0,
          ),
        ),
        decoration: BoxDecoration(
          color: kGray,
          borderRadius: BorderRadius.circular(20),
        ),
      );
    }
  }
}

class CoinContainer extends StatefulWidget {
  const CoinContainer({Key? key, required this.index});
  final int index;
  @override
  _CoinContainerState createState() => _CoinContainerState(index: index);
}

class _CoinContainerState extends State<CoinContainer> {
  _CoinContainerState({Key? key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        coins[index]["name"],
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
    );
  }
}
