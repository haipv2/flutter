import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image, Codec, instantiateImageCodec;

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Experiments',
      theme: new ThemeData(),
      home: new Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {

  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool reDraw = false;
  int tileLevelVertical = 3;
  int tileLevelHorizontal = 2;
  double tileWidth;
  double tileHeight;
  Rect rectSrc;
  Rect rectDes;
  ui.Image image;

  Future<ui.Image> loatImage(String s) async {
    ByteData data = await rootBundle.load(s);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo frameInfo = await codec.getNextFrame();
    image = frameInfo.image;
    return image;
  }

  @override
  Widget build(BuildContext context) {
    loatImage('images/smile.png').then((image) {
      tileWidth = image.width / tileLevelVertical;
      tileHeight = image.width / tileLevelHorizontal;
      rectSrc = Rect.fromLTWH(0.0, 0.0, tileWidth, tileHeight);
      rectDes = Rect.fromLTRB(
          rectSrc.left, rectSrc.top, rectSrc.right, rectSrc.bottom);
    });
    return Container(
      child: GestureDetector(
        onTapDown: changeRedraw,
        child: CustomPaint(
          foregroundPainter:
              MyPainter(reDraw, image, rectSrc, rectDes),
        ),
      ),
    );
  }

  changeRedraw(TapDownDetails details) {
    reDraw = true;
    setState(() {});
  }
}

class MyPainter extends CustomPainter {
  bool reDraw;
  ui.Image image;
  Rect rectSrc;
  Rect rectDes;

  MyPainter(this.reDraw, this.image, this.rectSrc, this.rectDes);

  @override
  void paint(Canvas canvas, Size size) {
    print('painting.....');
    if (image != null) {
      canvas.drawImageRect(image, rectSrc, rectDes, Paint());
    }

    print('END: paint');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    print('rpainting.....');
    return false;
  }
}
