import 'package:cryplens/screens/coin_page.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:cryplens/widgets/NavBar.dart';

//dummy list of coins before api, you may change the number of generated coins
final List<Map> coins =
    List.generate(1, (index) => {"id": index, "name": "Coin $index"}).toList();

class PouchPage extends StatefulWidget {
  const PouchPage({Key? key}) : super(key: key);

  @override
  _PouchPageState createState() => _PouchPageState();
}

class _PouchPageState extends State<PouchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: PouchContent(),
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
              'Hi Agent, listed here are the contents of your pouch',
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
        child: InkWell(
          onTap: () {
            print('clicked');
          },
          child: Container(
            width: 500,
            height: 500,
            child: Center(
              child: Text(
                "Add new coins from the coin catalog",
                style: TextStyle(
                  color: kWhite,
                  fontFamily: 'Spartan MB',
                  fontSize: 15.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kGray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinPage(),
            ),
          );
        },
        child: Container(
          width: 500,
          height: 500,
          child: Center(
            child: Text(
              coins[index]["name"],
              style: TextStyle(
                color: kWhite,
                fontFamily: 'Spartan MB',
                fontSize: 30.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: kGray,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
