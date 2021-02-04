import 'package:animationmusic/app/models/video_model.dart';
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

  bool listOpen = false;
  bool _animationTwo = false;

  void changeCurrentVideo(Video video) {
    setState(() {
      currentVideo = video;
    });
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _animationTwo = true;
      });
    });
  }

  @override
  void initState() {
    currentVideo = widget.video;

    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<VideoController>();

    YoutubePlayerController _controllerVideo = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(currentVideo.url),
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ));

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
        builder: (context, constraints) {
          if (constraints.maxHeight > constraints.maxWidth) {
            return Stack(
              children: <Widget>[
                AnimatedPositioned(
                  top: _animationTwo ? 0 : constraints.maxHeight,
                  curve: Curves.easeInOutQuint,
                  duration: Duration(seconds: 3),
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                              initialVideoId: YoutubePlayer.convertUrlToId(
                                  currentVideo.url),
                              flags: YoutubePlayerFlags(
                                autoPlay: true,
                              )),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.red,
                          progressColors: ProgressBarColors(
                              playedColor: Colors.red,
                              handleColor: Colors.redAccent),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text('Lista de adicionados')),
                            Observer(builder: (_) {
                              return RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      listOpen = !listOpen;
                                    });
                                  },
                                  child: Column(children: <Widget>[
                                    Icon(Icons.list),
                                    Text(listOpen
                                        ? 'Esconder Lista'
                                        : 'Mostrar lista')
                                  ]));
                            }),
                            Observer(
                              builder: (_) {
                                var allowed =
                                    controller.existingItem(currentVideo);
                                return RaisedButton(
                                    onPressed: () {
                                      allowed
                                          ? controller.removeVideo(currentVideo)
                                          : controller.addVideo(currentVideo);
                                    },
                                    child: Column(children: <Widget>[
                                      Icon(allowed
                                          ? Icons.remove_circle
                                          : Icons.add),
                                      Text(allowed ? 'Remover' : 'Adicionar')
                                    ]));
                              },
                            )
                          ],
                        ),
                        AnimatedContainer(
                            height: listOpen ? constraints.maxHeight * 0.4 : 0,
                            duration: Duration(seconds: 2),
                            child: Observer(builder: (_) {
                              return ListView.builder(
                                  itemCount: controller.listVideos.length,
                                  itemBuilder: (ctx, index) => YoutubeWidget(
                                      video: controller.listVideos[index]));
                            }))
                      ]),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
                child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: YoutubePlayer(
                          controller: _controllerVideo,
                        ))));
          }
        },
      ),
    );
  }
}
