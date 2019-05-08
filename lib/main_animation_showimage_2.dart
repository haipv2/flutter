import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  String imageUrl = '';
  Animation<double> animation;
  AnimationController controller;
  double width = 300;
  double height = 300;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
//    animation = CurvedAnimation(
//        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: pi / 2).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 300,
            width: 300,
            child: imageUrl.isEmpty ? Container() : Image.asset(imageUrl),
          ),
          RaisedButton(
            onPressed: _showImage,
            child: Text('Click'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showImage() {
    print('press show image');
    controller.addListener(() {
      setState(() {
        print('ADD LISTENER: ${animation.value}');
        imageUrl = 'assets/images/p.png';
      });
    });
    controller.forward().orCancel;
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
}
