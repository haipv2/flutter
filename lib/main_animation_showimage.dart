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
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: animation.value,
            width: animation.value,
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
        imageUrl = 'assets/images/p.png';
      });
    });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
}
