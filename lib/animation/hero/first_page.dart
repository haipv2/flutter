import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'abc',
              child: Icon(
                Icons.image,
                size: 50.0,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/2");
              },
              child: Text('Button'),
            )
          ],
        ),
      ),
    );
  }
}

