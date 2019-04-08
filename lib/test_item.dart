import 'package:flutter/material.dart';

class TestItem extends StatefulWidget {
  int index;
  Color color = Colors.grey;
  int event;
  Widget child;
  Text text;
  bool reset;
  ValueChanged<bool> onReset;
  TestItem({this.index, this.event, this.child, this.text, this.color, this.reset});

  @override
  _TestItemState createState() => _TestItemState(index);
}

class _TestItemState extends State<TestItem> {
  var activePlayer;
  int index;
  Image image;
  bool reset=false;
  ValueChanged<bool> onReset;

  _TestItemState(this.index);

  @override
  void initState() {
    super.initState();
    activePlayer = 1;

  }

  @override
  Widget build(BuildContext context) {
    print('----------build------_TestItemState');

    return GestureDetector(
      onTap: () {
        _changeImage(activePlayer);
      },
      child: image,
    );
  }

  void _changeImage(activePlayer) {
    setState(() {
      if (activePlayer != 1 && activePlayer != 2) {
        image = Image.asset('assets/b1.png');
        this.activePlayer = 1;
        this.reset = true;
      } else {
        if (activePlayer == 1) {
          this.activePlayer = 2;
        } else if (activePlayer == 2) {
          this.activePlayer = 1;
        }
        image = Image.asset('assets/p$activePlayer''.jpeg');
      }
    });
  }
}
