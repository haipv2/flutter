import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_stories/components/stories_list_skeleton.dart';
import 'package:flutter_instagram_stories/grouped_stories_view.dart';
import 'package:flutter_instagram_stories/models/stories.dart';
import 'package:flutter_instagram_stories/models/stories_data.dart';
import 'package:flutter_instagram_stories/models/stories_list_with_pressed.dart';
import 'package:flutter_instagram_stories/models/story_data.dart';
import 'package:flutter_stories/flutter_stories.dart';

class VideoStory extends StatefulWidget {
  /// the name of collection in Firestore, more info here https://github.com/awaik/flutter_instagram_stories
  String languageCode='en';

  /// highlight last icon (story image preview)
  bool lastIconHighlight;
  Color lastIconHighlightColor;
  Radius lastIconHighlightRadius;

  /// preview images settings
  double iconWidth;
  double iconHeight;
  bool showTitleOnIcon = true;
  TextStyle iconTextStyle;
  BoxDecoration iconBoxDecoration;
  BorderRadius iconImageBorderRadius;
  EdgeInsets textInIconPadding;

  /// how long story lasts
  int imageStoryDuration;

  /// background color between stories
  Color backgroundColorBetweenStories;

  /// stories close button style
  Icon closeButtonIcon;
  Color closeButtonBackgroundColor;

  /// stories sorting order Descending
  bool sortingOrderDesc;

  /// callback to get data that stories screen was opened
  VoidCallback backFromStories;

  ProgressPosition progressPosition;
  bool repeat;
  bool inline;

  VideoStory({this.lastIconHighlight = false,
    this.lastIconHighlightColor = Colors.deepOrange,
    this.lastIconHighlightRadius = const Radius.circular(15.0),
    this.iconWidth,
    this.iconHeight,
    this.showTitleOnIcon,
    this.iconTextStyle,
    this.iconBoxDecoration,
    this.iconImageBorderRadius,
    this.textInIconPadding =
    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
    this.imageStoryDuration,
    this.backgroundColorBetweenStories,
    this.closeButtonIcon,
    this.closeButtonBackgroundColor,
    this.sortingOrderDesc = true,
    this.backFromStories,
    this.progressPosition = ProgressPosition.bottom,
    this.repeat = true,
    this.inline = false,
    this.languageCode = 'en'});

  @override
  _VideoStoryState createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  StoriesData _storiesData;
  bool _backStateAdditional = false;

  @override
  void initState() {
    _storiesData = StoriesData(languageCode: widget.languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.iconHeight + 24,
      child: buildContent(),
    );
  }

  _buildFuture(String res) async {
    await Future.delayed(const Duration(seconds: 1));
//    if (res == 'back_from_stories_view' && !_backStateAdditional) {
    widget.backFromStories();
//    }
  }

  buildListStories() {
    List<Stories> result = [];
    result.add(Stories()
      ..storyId = 'abc'
      ..date = DateTime.now()
      ..previewTitle = {'preivewTitle': 'preivewTitle'}
      ..file = [StoryData()
        ..filetype = 'video'
        ..fileTitle = {
          'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        }..url={
          'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        }
      ]
      ..previewImage = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',);
    result.add(Stories()
      ..storyId = 'abc'
      ..date = DateTime.now()
      ..previewTitle = {'preivewTitle': 'preivewTitle'}
      ..file = [StoryData()
        ..filetype = 'video'
        ..fileTitle = {
          'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
        }..url={
          'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
        }
      ]
      ..previewImage = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',);
    return result;
  }

  Widget buildContent() {
      final stories = buildListStories();

    final List<Stories> storyWidgets =buildListStories();

//    _storiesData.parseStoriesPreview(stories);

    // the variable below is for passing stories ids to screen Stories
    final List<String> storiesIdsList = _storiesData.storiesIdsList;

    _buildFuture('');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: storyWidgets == null ? 0 : stories.length,
      itemBuilder: (BuildContext context, int index) {
        Stories story = storyWidgets[index];
        story.previewTitle.putIfAbsent(widget.languageCode, () => '');

        if (index == 0 && widget.lastIconHighlight) {
          return Padding(
            padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 16.0),
            child: InkWell(
              child: DottedBorder(
                color: widget.lastIconHighlightColor,
                dashPattern: [8, 4],
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: widget.lastIconHighlightRadius,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: widget.iconBoxDecoration,
                    width: widget.iconWidth,
                    height: widget.iconHeight,
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: widget.iconImageBorderRadius,
                        child: CachedNetworkImage(
                          imageUrl: story.previewImage,
                          width: widget.iconWidth,
                          height: widget.iconHeight,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              StoriesListSkeletonAlone(
                                width: widget.iconWidth,
                                height: widget.iconHeight,
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: widget.textInIconPadding,
                              child: Text(
                                story.previewTitle[widget.languageCode],
                                style: widget.iconTextStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              onTap: () async {
                _backStateAdditional = true;
//                  Navigator.pushAndRemoveUntil(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => GroupedStoriesView(
//                        collectionDbName: widget.collectionDbName,
//                        languageCode: widget.languageCode,
//                        imageStoryDuration: widget.imageStoryDuration,
//                        progressPosition: widget.progressPosition,
//                        repeat: widget.repeat,
//                        inline: widget.inline,
//                        backgroundColorBetweenStories:
//                        widget.backgroundColorBetweenStories,
//                        closeButtonIcon: widget.closeButtonIcon,
//                        closeButtonBackgroundColor:
//                        widget.closeButtonBackgroundColor,
//                        sortingOrderDesc: widget.sortingOrderDesc,
//                      ),
//                      settings: RouteSettings(
//                        arguments: StoriesListWithPressed(
//                            pressedStoryId: story.storyId,
//                            storiesIdsList: storiesIdsList),
//                      ),
//                    ),
//                    ModalRoute.withName('/'),
//                  );
              },
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 16.0),
            child: InkWell(
              child: Container(
                decoration: widget.iconBoxDecoration,
                width: widget.iconWidth,
                height: widget.iconHeight,
                child: Stack(children: <Widget>[
                  ClipRRect(
                    borderRadius: widget.iconImageBorderRadius,
                    child: CachedNetworkImage(
                      imageUrl: story.previewImage,
                      width: widget.iconWidth,
                      height: widget.iconHeight,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          StoriesListSkeletonAlone(
                            width: widget.iconWidth,
                            height: widget.iconHeight,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                  Container(
                    width: widget.iconWidth,
                    height: widget.iconHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: widget.textInIconPadding,
                          child: Text(
                            story.previewTitle[widget.languageCode],
                            style: widget.iconTextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              onTap: () async {
                _backStateAdditional = true;
//                Navigator.pushAndRemoveUntil(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) =>
//                        GroupedStoriesView(
//                          collectionDbName: widget.collectionDbName,
//                          languageCode: widget.languageCode,
//                          imageStoryDuration: widget.imageStoryDuration,
//                          progressPosition: widget.progressPosition,
//                          repeat: widget.repeat,
//                          inline: widget.inline,
//                          backgroundColorBetweenStories:
//                          widget.backgroundColorBetweenStories,
//                          closeButtonIcon: widget.closeButtonIcon,
//                          closeButtonBackgroundColor:
//                          widget.closeButtonBackgroundColor,
//                          sortingOrderDesc: widget.sortingOrderDesc,
//                        ),
//                    settings: RouteSettings(
//                      arguments: StoriesListWithPressed(
//                          pressedStoryId: story.storyId,
//                          storiesIdsList: storiesIdsList),
//                    ),
//                  ),
//                  ModalRoute.withName('/'),
//                );
              },
            ),
          );
        }
      },
    );

//      return ListView.builder(
//        scrollDirection: Axis.horizontal,
//        primary: false,
//        itemCount: 3,
//        itemBuilder: (BuildContext context, int index) {
//          return Padding(
//            padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 16.0),
//            child: InkWell(
//              child: Container(
//                width: widget.iconWidth,
//                height: widget.iconHeight,
//                child: Stack(
//                  children: <Widget>[
//                    ClipRRect(
//                      borderRadius: widget.iconImageBorderRadius,
//                      child: StoriesListSkeletonAlone(
//                        width: widget.iconWidth,
//                        height: widget.iconHeight,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        },
//      );

  }

//  String buildStory() {
//    Map<String,dynamic> map ={};
//    map[]
//    return result;
//  }
//  }
}
