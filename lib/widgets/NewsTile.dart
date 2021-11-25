import 'package:cryplens/constants.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc;
  NewsTile({required this.imageUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(imageUrl, height: 200,)),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: kArticleTitleTextStyle,
          ),
          Expanded(
            child: Text(
              desc,
              style: kArticleTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
