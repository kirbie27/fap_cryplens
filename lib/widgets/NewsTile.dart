import 'package:cryplens/constants.dart';
import 'package:cryplens/screens/article_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  NewsTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ArticleView(articleURL: url))
        );
      },
      child: Container(
        height: 325,
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.only(bottom: 16, top: 10),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(imageUrl, height: 200,)
            ),
            SizedBox(height: 8,),
            Text(
              title,
              style: kArticleTitleTextStyle,
            ),
            SizedBox(height: 8,),
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
