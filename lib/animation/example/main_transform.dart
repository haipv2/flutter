import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(1.0, 0.0, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Transform.rotate(
        angle: pi / 2.0,
        alignment: Alignment.topLeft,
        origin: Offset.zero,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Opacity(
            opacity: animation.value,
            child: Text(
              'ABCD',
              style: TextStyle(fontSize: 50.0, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
