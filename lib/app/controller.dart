import 'package:mobx/mobx.dart';
import './models/video_model.dart';

part "controller.g.dart";

class VideoController = VideoBase with _$VideoController;

abstract class VideoBase with Store {
  @observable
  ObservableList<Video> listVideos = <Video>[].asObservable();

  @action
  void addVideo(Video video) {
    bool addAllowed = listVideos
            .where((element) => element.url == video.url)
            .toList()
            .length >
        0;

    if (!addAllowed) {
      listVideos.add(video);
    }
  }

  @action
  void removeVideo(Video video) {
    listVideos.removeWhere((element) => element.url == video.url);
  }
}
