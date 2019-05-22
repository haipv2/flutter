import 'package:flutter/material.dart';

void main() => runApp(MyAPp());

class MyAPp extends StatefulWidget {
  @override
  _MyAPpState createState() => _MyAPpState();
}

class _MyAPpState extends State<MyAPp> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 3000.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedBuilder(
        animation: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform.scale(
              scale: 0.5,
              child: Image.asset('assets/images/p.png'),
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('ShowImg'),
              onPressed: () {
                _controller.forward();
              },
            )
          ],
        ),
      ),
    );
  }
}
