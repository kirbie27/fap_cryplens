import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  double computeHeight(int desc) {
    //print('length $desc');
    //dynamically computes the better fit height for each news article.
    return 290 + 10 * (desc / 50.0);
  }

  NewsTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(articleURL: url)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(18),
        ),
        height: computeHeight(desc.length),
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 30),
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                  height: 170,
                )),
            SizedBox(height: 8),
            Text(
              title,
              style: kArticleTitleTextStyle,
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                desc,
                style: kArticleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
