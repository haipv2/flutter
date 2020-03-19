import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

CacheUtils cacheManager = CacheUtils();

class CacheUtils extends BaseCacheManager {
  static const key = "customCache";

  static CacheUtils _instance;

  factory CacheUtils() {
    return _instance ??= CacheUtils._();
  }
  static var mngr = DefaultCacheManager();
  static Future<bool> cacheImg(mediaResources) async {
      for (final media in mediaResources) {
        final file = await mngr.getSingleFile(
          media,
        );
        await _loadAsyncFromFile(
            CachedNetworkImageProvider(media), file);
      }
  }

  static Future<ui.Codec> _loadAsyncFromFile(
      CachedNetworkImageProvider key, File file) async {
    final Uint8List bytes = await file.readAsBytes();
    return await ui.instantiateImageCodec(bytes);
  }

  CacheUtils._()
      : super(key,
      maxAgeCacheObject: Duration(days: 1),
      maxNrOfCacheObjects: 200,
      fileFetcher: _customHttpGetter);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }

  static Future<FileFetcherResponse> _customHttpGetter(String url,
      {Map<String, String> headers}) async {
    // Do things with headers, the url or whatever.
    return HttpFileFetcherResponse(await http.get(url, headers: headers));
  }
}
