import 'package:animationmusic/app/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class YoutubeRender extends StatefulWidget {
  static String routeName = '/video';
  final Video video;

  const YoutubeRender({Key key, this.video}) : super(key: key);

  @override
  _YoutubeRenderState createState() => _YoutubeRenderState();
}

class _YoutubeRenderState extends State<YoutubeRender>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  bool _animationTwo = false;

  void startAnimation() async {
    setState(() {
      _animationTwo = true;
    });

    _controller.forward();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.video_collection_sharp, color: Colors.red),
            SizedBox(width: 10),
            Text('Videoski')
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraits) {
          return Container(
            child: AnimatedPositioned(
              top: _animationTwo ? 0 : constraits.maxHeight,
              curve: Curves.easeInExpo,
              duration: Duration(seconds: 3),
              child: FadeTransition(
                opacity: _animation,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                      initialVideoId:
                          YoutubePlayer.convertUrlToId(widget.video.url),
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                      )),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blue,
                  progressColors: ProgressBarColors(
                      playedColor: Colors.blue, handleColor: Colors.blueAccent),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
