import 'dart:io';

import 'package:video_player/video_player.dart';

enum VideoResources { NETWORK, FILE }

class VideoLoader {
  VideoLoader._internal();

  static final VideoLoader _VideoLoader = VideoLoader._internal();

  factory VideoLoader() {
    return _VideoLoader;
  }

  static Future<void> initData(
      String mediaUrl, VideoResources resources) async {
    if (resources == VideoResources.NETWORK)
      VideoPlayerController.network(mediaUrl)
        ..initialize();
    else
      VideoPlayerController.file(File(mediaUrl))
        ..initialize();
  }

  Future<void> loadVideo(String url) async{
   await VideoPlayerController.network(url)
      ..initialize()..addListener((){
     });

  }


  static Future<VideoPlayerController> getController(String mediaUrl) async{
    await VideoPlayerController.network(mediaUrl).initialize();
    return VideoPlayerController.network(mediaUrl);
  }
}

VideoLoader videoLoader = VideoLoader();
