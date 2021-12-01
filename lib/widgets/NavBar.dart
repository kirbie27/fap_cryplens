import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBarContent extends StatefulWidget {
  const NavBarContent({Key? key}) : super(key: key);

  @override
  _NavBarContent createState() => _NavBarContent();
}

class _NavBarContent extends State<NavBarContent> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Text(
      "Catalog",
    ),
    Text(
      "Wallet",
    ),
    Text(
      "Checker",
    ),
  ];

  void onTabTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _children[_currentIndex]),
      bottomNavigationBar: NavBar(
        selectedIndex: _currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({this.selectedIndex = 0, required this.onTap});

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kGray,
      iconSize: 20,
      showSelectedLabels: false,
      selectedFontSize: 12,
      showUnselectedLabels: false,
      selectedItemColor: kWhite,
      unselectedItemColor: kGraySelected,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: "Catalog",
            activeIcon: FaIcon(FontAwesomeIcons.book, size: 30)),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.wallet),
            label: "Pouch",
            activeIcon: FaIcon(FontAwesomeIcons.wallet, size: 30)),
        BottomNavigationBarItem(
            icon: Image.asset('assets/images/cryplensLOGOGRAY.png',
                width: 30, height: 30),
            label: "Luna",
            activeIcon: Image.asset('assets/images/cryplensLOGO80.png',
                width: 32, height: 32)),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidNewspaper),
            label: "CryptoPaper",
            activeIcon: FaIcon(FontAwesomeIcons.solidNewspaper, size: 30)),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.infoCircle),
            label: "Manual",
            activeIcon: FaIcon(FontAwesomeIcons.infoCircle, size: 30)),
      ],
    );
  }
}
