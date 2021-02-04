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
  bool _animationTwo = false;

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _animationTwo = true;
      });
    });
  }

  @override
  void initState() {
    startAnimation();
    super.initState();
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraits) {
          return Stack(
            children: <Widget>[
              AnimatedPositioned(
                top: _animationTwo ? 0 : constraits.maxHeight,
                curve: Curves.easeInOutQuint,
                duration: Duration(seconds: 3),
                child: Container(
                  width: constraits.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                          initialVideoId: YoutubePlayer.convertUrlToId(
                              'https://youtu.be/h6BSKFAZ37E?list=RDh6BSKFAZ37E'),
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                          )),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.redAccent),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
