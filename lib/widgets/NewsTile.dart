import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc;
  NewsTile({required this.imageUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            desc,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
