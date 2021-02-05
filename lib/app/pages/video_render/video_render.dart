import 'package:animationmusic/app/models/video_model.dart';
import 'package:animationmusic/app/widgets/alert_flushbar.dart';
import 'package:animationmusic/app/widgets/video_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../controller.dart';

class YoutubeRender extends StatefulWidget {
  static String routeName = '/video';
  final Video video;

  const YoutubeRender({Key key, this.video}) : super(key: key);

  @override
  _YoutubeRenderState createState() => _YoutubeRenderState();
}

class _YoutubeRenderState extends State<YoutubeRender>
    with SingleTickerProviderStateMixin {
  Video currentVideo;

  YoutubePlayerController _controllerVideo;

  bool listOpen = false;
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
    super.initState();
    currentVideo = widget.video;

    _controllerVideo = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.video.url),
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ));

    currentVideo = widget.video;
    startAnimation();
  }

  Widget buttonCategory(Function callback, IconData icon, String text) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
        ),
        child: Column(children: <Widget>[
          Icon(icon, color: Colors.black),
          Text(text, style: TextStyle(color: Colors.black))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<VideoController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.video_collection_sharp, color: Colors.red),
            SizedBox(width: 10),
            Text('Videoski Player')
          ],
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            AnimatedPositioned(
              top: _animationTwo ? 0 : constraints.maxHeight,
              duration: Duration(seconds: 3),
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    YoutubePlayer(
                      controller: _controllerVideo,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text('Últimas pesquisas',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25))),
                        Expanded(
                          child: buttonCategory(
                              () => {
                                    controller.listVideos.length == 0 &&
                                            !listOpen
                                        ? FlushBarAlert(
                                            title: 'Lista vazia',
                                            message: 'Adicione um item.',
                                          )
                                        : setState(() {
                                            listOpen = !listOpen;
                                          })
                                  },
                              Icons.list,
                              listOpen ? 'Esconder Lista' : 'Mostrar lista'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buttonCategory(
                            () => {controller.addVideo(currentVideo)},
                            Icons.add,
                            'Adicionar'),
                      ],
                    ),
                    SizedBox(height: 20),
                    AnimatedContainer(
                        height: listOpen ? 200 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Observer(builder: (_) {
                          return ListView.builder(
                              itemCount: controller.listVideos.length,
                              itemBuilder: (ctx, index) => YoutubeWidget(
                                  video: controller.listVideos[index],
                                  changeVideo: () {
                                    setState(() {
                                      currentVideo =
                                          controller.listVideos[index];
                                    });
                                  }));
                        }))
                  ]),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
