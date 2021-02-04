import 'package:animationmusic/app/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controller.dart';

class YoutubeWidget extends StatelessWidget {
  final Video video;

  const YoutubeWidget({Key key, @required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<VideoController>();

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: YoutubePlayer(
          controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(video.url),
              flags: YoutubePlayerFlags(
                autoPlay: true,
              )),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
              playedColor: Colors.red, handleColor: Colors.redAccent),
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => controller.removeVideo(video)),
      ),
    );
  }
}
