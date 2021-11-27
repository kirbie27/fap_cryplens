import 'dart:async';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'dart:math' as math;
import 'package:cryplens/screens/coin_page.dart';

final List<Map> coins =
    List.generate(2, (index) => {"id": index, "name": "Coin $index"}).toList();

class CatalogPage extends StatefulWidget {
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<CatalogPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CatalogContent(),
        ),
      ),
    );
  }
}

class CatalogContent extends StatefulWidget {
  const CatalogContent({Key? key}) : super(key: key);

  @override
  _CatalogContentState createState() => _CatalogContentState();
}

class _CatalogContentState extends State<CatalogContent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        flex: 1,
        child: SearchBarWidget(),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
        flex: 1,
        child: SortWidget(),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
        flex: 5,
        child: CoinListWidget(),
      ),
    ]);
  }
}

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

int toggle = 1;

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 250.0,
      alignment: Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 48.0,
        width: (toggle == 0) ? 48.0 : 250.0,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: kGray,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: 6.0,
              left: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff2f3f7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    child: Icon(
                      Icons.search,
                      color: kWhite,
                      size: 20.0,
                    ),
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 2.0 * math.pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 375),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: 23.0,
                  width: 180.0,
                  child: TextField(
                    controller: _textEditingController,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    cursorColor: kWhite,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Enter coin code...',
                      labelStyle: TextStyle(
                        color: Colors.white24,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: kGray,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon: Icon(
                  Icons.search,
                  color: kWhite,
                  size: 18.0,
                ),
                onPressed: () {
                  setState(
                    () {
                      if (toggle == 0) {
                        toggle = 1;
                        _con.forward();
                      } else {
                        toggle = 0;
                        _textEditingController.clear();
                        _con.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortWidget extends StatefulWidget {
  const SortWidget({Key? key}) : super(key: key);

  @override
  _SortWidgetState createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  bool isFirstDropdownOpened = false;
  bool isSecondDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Sort by:",
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
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFirstDropdownOpened = !isFirstDropdownOpened;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "Market Cap",
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 20.0,
                              ),
                            ),
                            Spacer(),
                            Icon(
                                isFirstDropdownOpened
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: kWhite),
                          ],
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
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSecondDropdownOpened = !isSecondDropdownOpened;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "Ascending",
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: 'Spartan MB',
                                fontSize: 20.0,
                              ),
                            ),
                            Spacer(),
                            Icon(
                                isSecondDropdownOpened
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: kWhite),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    ));
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
    if (coins.length > 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          mainAxisExtent: 80,
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
            height: 100,
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
