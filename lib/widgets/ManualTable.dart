import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualTable extends StatelessWidget {
  const ManualTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 32.0, 30.0),
      child: Table(
        children: [
          TableRow(children: [
            Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.book,
                  color: kWhite,
                  size: 40,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Card Catalog',
                      style: kArticleTitleTextStyle,
                    ))
              ],
            ),
            Column(
              children: [
                Text(
                  'This page contains a list of the top 250 Cryptocurrencies with their basic information.',
                  style: kManualTextStyle,
                ),
              ],
            )
          ]),
          rowSpacer,
          TableRow(children: [
            Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.wallet,
                  color: kWhite,
                  size: 40,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Pouch',
                      style: kArticleTitleTextStyle,
                    ))
              ],
            ),
            Column(
              children: [
                Text(
                  'This page contains your favorite coins for easy access.',
                  style: kManualTextStyle,
                ),
              ],
            )
          ]),
          rowSpacer,
          TableRow(children: [
            Column(
              children: [
                Image.asset('assets/images/cryplensLOGO80.png',
                    width: 70, height: 70),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Detective Luna',
                      style: kArticleTitleTextStyle,
                    ))
              ],
            ),
            Column(
              children: [
                Text(
                  'This is page checks your specified token/coin to see if it is malicious or not.',
                  style: kManualTextStyle,
                ),
              ],
            )
          ]),
          rowSpacer,
          TableRow(children: [
            Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.solidNewspaper,
                  color: kWhite,
                  size: 40,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'CryptoNews',
                      style: kArticleTitleTextStyle,
                    ))
              ],
            ),
            Column(
              children: [
                Text(
                  'This page contains news articles about Cryptocurrencies and other related information.',
                  style: kManualTextStyle,
                ),
              ],
            )
          ]),
          rowSpacer,
          TableRow(children: [
            Column(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: kWhite,
                  size: 40,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Manual',
                      style: kArticleTitleTextStyle,
                    ))
              ],
            ),
            Column(
              children: [
                Text(
                  'This page explains the features of the application, particularly the functions of the icons in the navigation bar.',
                  style: kManualTextStyle,
                ),
              ],
            )
          ])
        ],
      ),
    );
  }
}
