import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  double computeHeight(int desc, int title) {
    //print('length $desc');
    //dynamically computes the better fit height for each news article.
    return (50 + 15 * (desc / 50.0).ceil() + 15 * (title / 30.0).ceil())
        .toDouble();
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
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  kBlue.withOpacity(0.3), BlendMode.dstATop)),
        ),
        // height: computeHeight(desc.length, title.length),
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 8),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(10.0),
            //     child: Image.network(
            //       imageUrl,
            //       fit: BoxFit.fill,
            //       height: 170,
            //     )),
            // SizedBox(height: 8),
            Text(
              title,
              style: kArticleTitleTextStyle,
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                desc,
                style: kArticleTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(30.0),
            //     child: Container(
            //       width: 250,
            //       height: 30,
            //       color: kWhite,
            //       child: Container(
            //         margin: EdgeInsets.only(top: 7),
            //         child: Text(
            //           'READ FULL ARTICLE',
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     )),
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
