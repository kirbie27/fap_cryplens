import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryplens/screens/manual_page.dart';


class NavBar extends StatelessWidget {
  const NavBar({this.selectedIndex = 0, required this.onTap});

  final int selectedIndex;
  final void Function(int) onTap;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kGray,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: kGraySelected,
      unselectedItemColor: kWhite,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.book), title: Text('Home'),),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.wallet), title: Text('Home'),),
        BottomNavigationBarItem(icon: Image.asset('assets/images/cryplensLOGO80.png', width: 50, height: 50), title: Text('Home'),),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidNewspaper), title: Text('Home'),),
        BottomNavigationBarItem(icon: Icon(Icons.info_rounded), title: Text('Home'),),
      ],
    );
  }
}