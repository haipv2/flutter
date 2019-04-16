import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Cached Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: CachedNetworkImage(
//            placeholder: CircularProgressIndicator(),
//            placeholder: CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/250?image=9',
            placeholder: (context, url) => new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
