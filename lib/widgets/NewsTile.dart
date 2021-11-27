import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  double computeHeight(int desc) {
    //print('length $desc');
    //dynamically computes the better fit height for each news article.
    return 300 + 10 * (desc / 40.0);
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
        color: kBlue,
        height: computeHeight(desc.length),
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.only(bottom: 16, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  imageUrl,
                  height: 200,
                )),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: kArticleTitleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
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
