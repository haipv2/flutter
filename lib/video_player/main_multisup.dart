// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

/// An example of using the plugin, controlling lifecycle and playback of the
/// video.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'cache_utils.dart';
import 'multisup_player.dart';
import 'single_video_player.dart';

void main() {
  runApp(
    MaterialApp(
      home: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App2();
  }
}

class App2 extends StatefulWidget {

  @override
  _App2State createState() => _App2State();
}

class _App2State extends State<App2> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => App1(controller: _controller)));
      }, child: Text('CLICK HERE'),),
    );
  }

  void initVideo() async {
    _controller = VideoPlayerController.network(mediaResources[0])..initialize();
  }
}

class App1 extends StatefulWidget {
  final VideoPlayerController controller;

  const App1({Key key, this.controller}) : super(key: key);

  @override
  _App1State createState() => _App1State();
}

class _App1State extends State<App1> {
  @override
  void initState() {
    super.initState();
//    CacheUtils.cacheImg(mediaResources);
  }

  @override
  Widget build(BuildContext context) {
//    return  MultisupPlayerWidget();
    return SinglePlayerWidget(widget.controller);
  }
}
