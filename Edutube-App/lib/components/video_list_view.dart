// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:edutube/components/quiz_screen_view.dart';
import 'package:edutube/components/show_video.dart';
import 'package:edutube/components/theme.dart';
import 'package:edutube/models/videoslist.dart';
import 'package:flutter/material.dart';

class VideosListView extends StatefulWidget {
  final List<Map<String, dynamic>> videoData;
  final String playlistName;
  const VideosListView(
      {Key? key, required this.videoData, required this.playlistName})
      : super(key: key);

  @override
  _VideosListViewState createState() => _VideosListViewState();
}

class _VideosListViewState extends State<VideosListView>
    with TickerProviderStateMixin {
  List<VideosList> videoList = VideosList.videoList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.nearlyWhite,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              widget.videoData.length,
                              (int index) {
                                final int count = widget.videoData.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController?.forward();
                                return VideoListView(
                                  animation: animation,
                                  animationController: animationController,
                                  listData: VideosList(
                                      imagePath: widget.videoData[index]
                                          ["thumbnailLink"]),
                                  videoData: widget.videoData[index],
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: multiple ? 2 : 1,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.5,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Videos',
                  style: TextStyle(
                    fontSize: 22,
                    color: CustomAppTheme.nearlyYoutubeRed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: CustomAppTheme.nearlyYoutubeRed,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: CustomAppTheme.nearlyYoutubeRed,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: CustomAppTheme.nearlyYoutubeRed.withOpacity(0.5),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Center(
                  child: TextButton(
                child: Text(
                  'Quiz',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 0.0,
                    color: CustomAppTheme.nearlyWhite,
                  ),
                ),
                onPressed: () {
                  moveTo();
                },
              )),
            ),
          ),
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => QuizScreenView(courseName: widget.playlistName,channel: widget.videoData[0]["channelName"]),
      ),
    );
  }
}

class VideoListView extends StatelessWidget {
  const VideoListView(
      {Key? key,
      this.listData,
      this.animationController,
      this.animation,
      required this.videoData})
      : super(key: key);

  final VideosList? listData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final Map<String, dynamic> videoData;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.network(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => ShowVideo(
                                videoDetails:
                                    Map<String, dynamic>.from(videoData),
                              ),
                            ),
                          );
                        },
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
