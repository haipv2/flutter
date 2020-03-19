import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:testt/video_player/video_loader.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

import 'multisup_player.dart';

class SinglePlayerWidget extends StatefulWidget {
  final bool isShowSpeakerIcon;
  final int index, changedIndex;
  final VideoPlayerController controller;

  SinglePlayerWidget(this.controller, {
    this.isShowSpeakerIcon = false,
    this.index,
    this.changedIndex,
  });

  @override
  _SinglePlayerWidgetState createState() => _SinglePlayerWidgetState();
}

class _SinglePlayerWidgetState extends State<SinglePlayerWidget> {
  
  double volumeSet = 1.0;
  bool _disposed = false;
  Future<void> _initializeVideoPlayerFuture;
  var _isPlaying = false;
  var _isEndPlaying = false;
  int _playingIndex = -1;

  @override
  void initState() {
    super.initState();
//    _initializeVideoPlayerFuture = widget.controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    widget.controller.play();
    return Material(
      child: SizedBox(
        width: width,
        height: height,
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: Stack(
            children: <Widget>[
              VideoPlayer(
                widget.controller,
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
//                                _startPlay(_playingIndex - 1);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.index == widget.changedIndex ||
                (widget.index == 0 && null == widget.changedIndex)) {
              widget.controller.play();
            } else {
              widget.controller.pause();
            }

            return Material(
              child: SizedBox(
                width: width,
                height: height,
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(
                        widget.controller,
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
//                                _startPlay(_playingIndex - 1);
                              }
                            },
                          ),
                        ),
                      ),
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
          }
        });
  }

  @override
  void dispose() {
//    widget.controller?.dispose();
    super.dispose();
  }
}
