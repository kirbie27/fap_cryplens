import 'package:flutter/material.dart';
import 'package:cryplens/constants.dart';

class hello extends StatefulWidget {
  _helloState createState() => _helloState();
}

class _helloState extends State<hello> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (count < 3)
                count = count + 1;
              else
                Navigator.pushReplacementNamed(context, '/getname');
            });
          },
          //the indexed stack is used as a custom carousel to show the
          //features of the application.
          child: IndexedStack(
            index: count,
            children: [Intro1(), Intro2(), Intro3(), Intro4()],
          ),
        ),
      ),
    );
  }
}

class Intro4 extends StatelessWidget {
  const Intro4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/intro4.png'),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kGreen,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Intro3 extends StatelessWidget {
  const Intro3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/intro3.png'),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kGreen,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Intro2 extends StatelessWidget {
  const Intro2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/intro2.png'),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kGreen,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Intro1 extends StatelessWidget {
  const Intro1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/intro1.png'),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                color: kGreen,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 3),
              Icon(
                Icons.circle,
                color: kWhite,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
