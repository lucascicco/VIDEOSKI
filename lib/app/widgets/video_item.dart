import 'package:animationmusic/app/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/getData.dart';

import '../controller.dart';

class YoutubeWidget extends StatelessWidget {
  final Video video;
  final Function changeVideo;

  const YoutubeWidget(
      {Key key, @required this.video, @required this.changeVideo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<VideoController>();

    return FutureBuilder(
        future: GetDataClass().getData(video.url),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: changeVideo,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: Image.network(snapshot.data['thumbnail_url']),
                  title: Text(snapshot.data['title']),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => controller.removeVideo(video)),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar',
                    style: TextStyle(color: Colors.white)));
          } else {
            return Center(
                child: Text('Carregando...',
                    style: TextStyle(color: Colors.white)));
          }
        });
  }
}
