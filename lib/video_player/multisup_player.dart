import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:testt/video_player/video_loader.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

const mediaResources = [
  'https://firebasestorage.googleapis.com/v0/b/whatsupbackenddev.appspot.com/o/video%2F0XF4UemlLIPYK6sGHNZ5%2F3663121130311444126.mp4?alt=media&token=2e3b6281-d318-4672-92d4-8689d151bbcd',
  'https://firebasestorage.googleapis.com/v0/b/whatsupbackenddev.appspot.com/o/video%2F0frRsmJiXlPiOlKMRP5r%2F4442534463666652024.mp4?alt=media&token=2298ab79-4577-4857-99d9-030c16f8c847',
  'https://firebasestorage.googleapis.com/v0/b/whatsupbackenddev.appspot.com/o/video%2F0hzhxvNsKZ3Thx4uEYi5%2F2353245414643521561.mp4?alt=media&token=4d932f80-99d7-41b5-9a45-6c06abdb00d3',
  'https://firebasestorage.googleapis.com/v0/b/whatsupbackenddev.appspot.com/o/video%2F11nduzNJhN68gDIwdrrf%2F5341453465132543545.mp4?alt=media&token=0c37d7a8-cb86-4895-82a2-89136e16b449'
];

class MultisupPlayerWidget extends StatefulWidget {
  final bool isShowSpeakerIcon;
  final int index, changedIndex;

  MultisupPlayerWidget({
    this.isShowSpeakerIcon = false,
    this.index,
    this.changedIndex,
  });

  @override
  _MultisupPlayerWidgetState createState() => _MultisupPlayerWidgetState();
}

class _MultisupPlayerWidgetState extends State<MultisupPlayerWidget> {
  VideoPlayerController _controller;
  double volumeSet = 1.0;
  bool _disposed = false;
  Future<void> _initializeVideoPlayerFuture;
  var _isPlaying = false;
  var _isEndPlaying = false;
  int _playingIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializePlay(0);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.index == widget.changedIndex ||
                (widget.index == 0 && null == widget.changedIndex)) {
              _controller.play();
            } else {
              _controller.pause();
            }

            return Material(
              child: SizedBox(
                width: width,
                height: height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(
                        _controller,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: screenSize.width / 8,
                          height: screenSize.height,
                          child: InkWell(
                            onTap: () {
                              if (_playingIndex == 0) {
//                              widget.swiperController.previous(animation: true);
                              } else {
                                _startPlay(_playingIndex - 1);
                              }
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: screenSize.width / 8,
                          height: screenSize.height,
                          child: InkWell(
                            onTap: () {
//                            if (_playingIndex ==
//                                widget.post.mediaResources.length - 1)
//                              widget.swiperController.next(animation: true);
//                            else
                              _startPlay(_playingIndex + 1);
                            },
                          ),
                        ),
                      ),
                      widget.isShowSpeakerIcon
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  volumeSet == 0.0
                                      ? volumeSet = 1.0
                                      : volumeSet = 0.0;
                                  _controller.setVolume(volumeSet);
                                  setState(() {});
                                },
                                icon: Icon(
                                  volumeSet == 1.0
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ));
//            final mediaImgIntro =
//                widget.post.mediaResources[_playingIndex].mediaImgIntro;
//            return widget.post.isVideoFull
//                ? ListView(
//                    physics: const BouncingScrollPhysics(),
//                    shrinkWrap: true,
//                    children: [
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            SizedBox(
//                              width: screenSize.width,
//                              height: screenSize.height,
//                              child: Container(
//                                child: Image(
//                                  image: CachedNetworkImageProvider(
//                                    mediaImgIntro,
//                                  ),
//                                  fit: BoxFit.fill,
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                      ])
//                : ListView(
//                    physics: const BouncingScrollPhysics(),
//                    shrinkWrap: true,
//                    children: [
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            SizedBox(
//                              width: screenSize.width,
//                              height: screenSize.height * .7,
//                              child: Container(
//                                child: Image(
//                                  image: CachedNetworkImageProvider(
//                                    mediaImgIntro,
//                                  ),
//                                  fit: BoxFit.fill,
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                      ]);
          }
        });
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    _controller?.removeListener(_controllerListener);
    return true;
  }

  // tracking status
  Future<void> _controllerListener() async {
    if (_controller == null || _disposed) {
      return;
    }
    if (!_controller.value.initialized) {
      return;
    }
    final position = await _controller.position;
    final duration = _controller.value.duration;
    final isPlaying = duration == null
        ? false
        : position.inMilliseconds < duration.inMilliseconds;
    final isEndPlaying = position.inMilliseconds > 0 && duration == null
        ? false
        : position.inSeconds == duration.inSeconds;
    if (_isPlaying != isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      if (isEndPlaying) {
        final isComplete = _playingIndex == mediaResources.length - 1;
        if (!isComplete) {
          _startPlay(_playingIndex + 1);
        }
      }
    }
  }

  Future<void> _startPlay(int index) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    _clearPrevious().then((_) {
      _initializePlay(index);
    });
  }

  Future<void> _initializePlay(int index) async {
    _controller = await VideoLoader.getController(
      mediaResources[index],
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(_controllerListener);

    setState(() {
      _playingIndex = index;
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _initializeVideoPlayerFuture = null;
    _controller?.pause()?.then((_) {
      // dispose VideoPlayerController.
      _controller?.dispose();
    });
    super.dispose();
  }
}
