import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
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
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();

      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
//    controller.addStatusListener(handler);
//    animation = CurvedAnimation(
//        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeOut);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform:
                    Matrix4.translationValues(animation.value * width, 0, 0),
                child: imageUrl.isEmpty ? Container() : Image.asset(imageUrl),
              ),
              RaisedButton(
                onPressed: _showImage,
                child: Text('Click'),
              )
            ],
          ),
        );
      },
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
//        print('ADD LISTENER: ${animation.value}');
        imageUrl = 'assets/images/p.png';
      });
    });
    controller.forward().orCancel;
//    controller.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse();
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(handler);
      controller.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
//            Navigator.pop(context);
          }
        });
      controller.forward();
    }
  }
}
