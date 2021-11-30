import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kTitleTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25.0,
  color: kWhite,
);

const kArticleTitleTextStyle = TextStyle(
  fontFamily: 'Robotto',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: kWhite,
);

const kArticleTextStyle = TextStyle(
  fontFamily: 'Robotto',
  fontSize: 12,
  color: kWhite,
);

const kManualTextStyle = TextStyle(
  fontFamily: 'Robotto',
  fontSize: 15.0,
  color: kWhite,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kWhite = Color(0xccffffff);

const kGray = Color(0xff292929);

const kGraySelected = Color(0xff8C8C8C);

const kGraySearch = Color(0xffD0D0D0);

const kBlack = Color(0xff121212);

const kBlue = Color(0xffb102A43);

const kGreen = Color(0xff2abfa4);

const kRed = Color(0xffdb4d4d);

const rowSpacer = TableRow(children: [
  SizedBox(
    height: 20,
  ),
  SizedBox(
    height: 15,
  )
]);

const detectiveCryptoText =
    TextStyle(fontSize: 25.0, fontFamily: 'DMSans', color: Colors.white);

const detectiveCryptoPadding =
    EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0);

const detectiveCryptoIcon =
    Icon(Icons.collections_bookmark, color: Colors.white, size: 40.0);

const detectiveCryptoResultText =
TextStyle(fontSize: 25.0, fontFamily: 'DMSans', color: Colors.white);

const Loading = SpinKitFadingFour(
  color: Colors.white,
  size: 50.0,
);

const startupLoad = SpinKitFadingCube(
  color: kWhite,
  size: 50.0,
);

