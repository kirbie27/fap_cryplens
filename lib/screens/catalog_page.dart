import 'dart:async';
import 'package:cryplens/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/constants.dart';
import 'dart:math' as math;

class CatalogPage extends StatefulWidget {
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<CatalogPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: CatalogContent(),
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
      Expanded(
        flex: 1,
        child: SortWidget(),
      ),
      Expanded(
        flex: 4,
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

  int _currentIndex = 0;
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
          color: Colors.white,
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
                      color: Colors.black,
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
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Search...',
                      labelStyle: TextStyle(
                        color: Color(0xff5B5B5B),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
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
  @override
  Widget build(BuildContext context) {
    return Container();
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
