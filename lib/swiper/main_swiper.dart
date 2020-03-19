import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/cupertino.dart';

import 'ExampleCustom.dart';
import 'ExampleSwiperInScrollView.dart';
import 'config.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Swiper'),
      //home: buildHome(),
      routes: {
        '/example01': (BuildContext context) => new ExampleHorizontal(),
        '/example02': (BuildContext context) => new ExampleVertical(),
        '/example03': (BuildContext context) => new ExampleFraction(),
        '/example04': (BuildContext context) => new ExampleCustomPagination(),
        '/example05': (BuildContext context) => new ExamplePhone(),
        '/example06': (BuildContext context) => new ScaffoldWidget(
            child: new ExampleSwiperInScrollView(), title: "ScrollView"),
        '/example07': (BuildContext context) => new ScaffoldWidget(
          child: new ExampleCustom(),
          title: "Custom All",
        )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> render(BuildContext context, List children) {
    return ListTile.divideTiles(
        context: context,
        tiles: children.map((dynamic data) {
          return buildListTile(context, data[0], data[1], data[2]);
        })).toList();
  }

  Widget buildListTile(
      BuildContext context, String title, String subtitle, String url) {
    return new ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      isThreeLine: true,
      dense: false,
      leading: null,
      title: new Text(title),
      subtitle: new Text(subtitle),
      trailing: new Icon(
        Icons.arrow_right,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime moonLanding = DateTime.parse("1969-07-20");

    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      body: new ListView(
        children: render(context, [
          ["Horizontal", "Scroll Horizontal", "/example01"],
          ["Vertical", "Scroll Vertical", "/example02"],
          ["Fraction", "Fraction style", "/example03"],
          ["Custom Pagination", "Custom Pagination", "/example04"],
          ["Phone", "Phone view", "/example05"],
          ["ScrollView ", "In a ScrollView", "/example06"],
          ["Custom", "Custom all properties", "/example07"]
        ]),
      ),
    );
  }
}

const List<String> titles = [
  "Flutter Swiper is awosome",
  "Really nice",
  "Yeap"
];

class ExampleHorizontal extends StatefulWidget {
  @override
  _ExampleHorizontalState createState() => _ExampleHorizontalState();
}

class _ExampleHorizontalState extends State<ExampleHorizontal> {

  SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController()..addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ExampleHorizontal"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
//                if (changedIndex == snapshot.data.listPost.length-2){
//                loadTime++;
                loadMoreData(scrollInfo);
            }
          },
          child: new Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.asset(
                images[index],
                fit: BoxFit.fill,
              );
            },

            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: false,
            itemCount: images.length,
            controller: _swiperController,
            loop: false,
//          pagination: new SwiperPagination(),
//          control: new SwiperControl(),
          ),
        ));
  }

  Future<void> _listener() async {
    print('abcd----------');
  }
  Future<void> loadMoreData(ScrollNotification notification) async {

    if (notification is ScrollEndNotification) {
      print('loadmoreeeeeeeeeee===111111111==============');
    }
//    print('loadmoreeeeeeeeeee=================');

  }
}

class ExampleVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ExampleVertical"),
        ),
        body: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(alignment: Alignment.centerRight),

//          control: new SwiperControl(),
        ));
  }
}

class ExampleFraction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("ExampleFraction"),
        ),
        body: new Column(
          children: <Widget>[
            Expanded(
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: images.length,
                  pagination:
                  new SwiperPagination(builder: SwiperPagination.fraction),
                  control: new SwiperControl(),
                )),
            Expanded(
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: images.length,
                  scrollDirection: Axis.vertical,
                  pagination: new SwiperPagination(
                      alignment: Alignment.centerRight,
                      builder: SwiperPagination.fraction),
                ))
          ],
        ));
  }
}

class ExampleCustomPagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Custom Pagination"),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: new SwiperPagination(
                    margin: new EdgeInsets.all(0.0),
                    builder: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Container(
                            color: Colors.white,
                            child: new Text(
                              "${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}",
                              style: new TextStyle(fontSize: 20.0),
                            )),
                        constraints: new BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: new SwiperControl(),
              ),
            ),
            new Expanded(
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: new SwiperPagination(
                    margin: new EdgeInsets.all(0.0),
                    builder: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              "${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            new Expanded(
                              child: new Align(
                                alignment: Alignment.centerRight,
                                child: new DotSwiperPaginationBuilder(
                                    color: Colors.black12,
                                    activeColor: Colors.black,
                                    size: 10.0,
                                    activeSize: 20.0)
                                    .build(context, config),
                              ),
                            )
                          ],
                        ),
                        constraints: new BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: new SwiperControl(color: Colors.redAccent),
              ),
            )
          ],
        ));
  }
}

class ExamplePhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Phone"),
      ),
      body: new Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: new BoxConstraints.expand(),
            child: new Image.asset(
              "images/bg.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          new Swiper.children(
            autoplay: false,
            pagination: new SwiperPagination(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 20.0,
                    activeSize: 20.0)),
            children: <Widget>[
              new Image.asset(
                "images/1.png",
                fit: BoxFit.contain,
              ),
              new Image.asset(
                "images/2.png",
                fit: BoxFit.contain,
              ),
              new Image.asset("images/3.png", fit: BoxFit.contain)
            ],
          )
        ],
      ),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  ScaffoldWidget({this.child, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        actions: actions,
      ),
      body: child,
    );
  }
}