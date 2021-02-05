import 'package:mobx/mobx.dart';
import './models/video_model.dart';

part "controller.g.dart";

class VideoController = VideoBase with _$VideoController;

abstract class VideoBase with Store {
  @observable
  ObservableList<Video> listVideos = <Video>[].asObservable();

  @action
  void addVideo(Video video, Function callback) {
    if (!listVideos.contains(video)) {
      listVideos.add(video);
    } else {
      callback();
    }
  }

  @action
  void removeVideo(Video video) {
    listVideos.removeWhere((element) => element.url == video.url);
  }
}
