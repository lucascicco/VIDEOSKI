import 'package:mobx/mobx.dart';
import '../../models/video_model.dart';
part "controller.g.dart";

class VideoController = VideoBase with _$VideoController;

abstract class VideoBase with Store {
  @observable
  ObservableList<dynamic> listVideos = [].asObservable();

  @action
  void addVideo(Video video) {
    listVideos.add(video);
  }

  @action
  void removeVideo(Video video) {
    listVideos.removeWhere((item) => item.url == video.url);
  }
}