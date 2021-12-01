import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  NewsTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    //GestureDetector is used to select the whole news tile to access the webview articles
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(articleURL: url)));
      },
      //This container contains the apis image network which serves as the background of the news tile
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
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kArticleTitleTextStyle,
            ),
            SizedBox(height: 8),
            //Flexible widget is used for the description of each articles which also came from the json file of the api
            //The ellipsis property is used to prevent overflow formatting
            Flexible(
              child: Text(
                desc,
                style: kArticleTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
