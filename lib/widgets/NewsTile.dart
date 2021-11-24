import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {

  final String imageUrl, title, desc;
  NewsTile({required this.imageUrl, required this.title, required this.desc});

  @override
  Widget  build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}
