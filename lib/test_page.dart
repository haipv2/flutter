import 'package:caro/test_item.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<TestItem> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) {
                  return new TestItem(index: i);
                }),
          ),
          TestItem(
            child: new Text(
              "Reset",
              style: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            reset: true,
          ),
        ],
      ),
    );
  }

  List<TestItem> doInit() {
    List<Widget> gameButtons = <TestItem>[
      TestItem(index: 1),
      TestItem(index: 2),
      TestItem(index: 3),
      TestItem(index: 4),
      TestItem(index: 5),
      TestItem(index: 6),
      TestItem(index: 7),
      TestItem(index: 8),
      TestItem(index: 9),
    ];
    return gameButtons;
  }

  void resetGame() {
    setState(() {});
  }
}
