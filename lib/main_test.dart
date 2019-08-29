import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'EXPLORE',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
//        leading: IconButton(
//          icon: Icon(Icons.menu),
//          onPressed: () => _scaffoldKey.currentState.openDrawer(),
//        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.message,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: bellIcon(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.view_module,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Container(
        child: SizedBox(
//          width: size.width * 3 / 4,
          child: Drawer(
              elevation: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    CustomPaint(
                      painter: ArcPainter(),
                      child: Container(
                        width: size.width,
                      ),
                    ),
                    AccountHeader(),
                    Container(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text('EXPLORE'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('HOME WORK'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text('AUDIO LIBRARY'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text('E-LEARNING'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
      body: ContentPage(),
    );
  }

  Widget homePageDrawer() {
    return Drawer();
  }

  searchIcon() {
    return Container(
      child: Icon(Icons.search),
    );
  }

  Widget bellIcon() {
    return Container(
      width: 20,
      height: PADDING_30,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 20,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 5),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc32c37),
                  border: Border.all(color: Colors.white, width: 1)),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Center(
          child: loadBg(size),
        ),
        Container(
          child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
//                  width: size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemInPage(index),
                  ),
                );
              }),
        )
      ],
    );
  }
}

Widget loadBg(Size size) {
  return Image(
    image: AssetImage('images/bg.png'),
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width / 2, size.height);
    Rect rect1 =
        Rect.fromLTWH(size.width / 2, 0.0, size.width / 2, size.height);
    canvas.drawRect(rect, Paint()..color = Color(0XFFE5E8E8));
    canvas.drawRect(rect1, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ItemInPage extends StatefulWidget {
  int index;

  ItemInPage(this.index);

  @override
  _ItemInPageState createState() => _ItemInPageState();
}

class _ItemInPageState extends State<ItemInPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.index == 5) {
      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: IconTheme(
              data: IconThemeData(color: Colors.blue),
              child: Icon(
                Icons.account_circle,
                size: 60,
              ),
            )),
      );
    }
    return Container(
      width: size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width * 0.7,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20.0,
                offset: Offset(5, 5),
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                              width: PADDING_30,
                              height: PADDING_30,
                              child: Image.asset('images/cat.jpg',
                                  fit: BoxFit.fill))),
                      Padding(
                        padding: const EdgeInsets.only(left: PADDING_30),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: Text(
                                  'Tiel',
                                  style: textStyle1,
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text(
                                  'Name Of class',
                                  style: textStyle1,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.watch_later,
                        size: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${Random().nextInt(20)} Min',
                          style: textStyle3,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.7,
            height: PADDING_30,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
              child: widget.index != 3
                  ? Text('Some Text goes here!!!!', style: textStyle4)
                  : Container(),
            ),
          ),
          Container(
              width: widget.index == 3 ? size.width * 0.7 : size.width * 0.8,
              height: 260,
              child: buildMiddleContetn(size, widget.index)),
          Container(
            height: 50,
            width: size.width * 0.7,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20.0,
                offset: Offset(5, 5),
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                        child: Icon(
                          Icons.favorite,
                          size: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          '${Random().nextInt(50)}',
                          style: textStyle3,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                        child: Icon(
                          Icons.mode_comment,
                          size: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          '${Random().nextInt(50)}',
                          style: textStyle3,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                            child: Icon(
                              Icons.share,
                              size: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              '${Random().nextInt(50)}',
                              style: textStyle3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildImageList(Size size) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: size.width * 0.8 * 0.6,
              child: Image.asset(
                'images/dish1.jpg',
                fit: BoxFit.fill,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: size.width * 0.8 * 0.4,
                  height: 130,
                  child: Image.asset(
                    'images/dish2.jpg',
                    fit: BoxFit.fitHeight,
                  )),
              Container(
                  width: size.width * 0.8 * 0.4,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'images/dish.jpg',
                        height: 130,
                        fit: BoxFit.fitHeight,
                      ),
                      Positioned(
                        left: 45,
                        top: 45,
                        child: Text(
                          '+7',
                          style: textStyle5,
                        ),
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMiddleContetn(Size size, int index) {
    if (widget.index == 1) {
      return buildImageList(size);
    }
    if (widget.index == 3) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(11),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Recently, the US Federal government banned online casinos from operating in America by making it illegal to transfer money to them through any US bank or payment system. As a result of this law, most of the popular online casino networks such as Party Gaming and PlayTech left the United States. Overnight, online casino players found themselves being chased by the Federal government. But, after a ',
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
    }
    return Image.asset('images/dish.jpg');
  }
}

class AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.blue,
      child: DrawerContent(),
    );
  }
}

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(
                  Icons.settings,
                  size: 25,
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/ava.jpg'), fit: BoxFit.cover),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HAIPV DEV',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconTheme(
                      data: IconThemeData(
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
                Container(
                  child: Text(
                    'First grade-b',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 150;
    Offset offset = Offset(size.width / 2, 0);

    Rect ovalRect = Rect.fromLTWH(0, 140, size.width, 20);
    canvas.drawOval(
        ovalRect,
        Paint()
          ..color = Colors.blue
          ..strokeCap = StrokeCap.butt
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

const textStyle1 =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 11);
const textStyle2 =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 10);
const textStyle3 =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 9);
const textStyle4 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13);
const textStyle5 =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
const double PADDING_30 = 30;
