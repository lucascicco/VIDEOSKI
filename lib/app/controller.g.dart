// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VideoController on VideoBase, Store {
  final _$listVideosAtom = Atom(name: 'VideoBase.listVideos');

  @override
  ObservableList<Video> get listVideos {
    _$listVideosAtom.reportRead();
    return super.listVideos;
  }

  @override
  set listVideos(ObservableList<Video> value) {
    _$listVideosAtom.reportWrite(value, super.listVideos, () {
      super.listVideos = value;
    });
  }

  final _$VideoBaseActionController = ActionController(name: 'VideoBase');

  @override
  void addVideo(Video video, Function callback) {
    final _$actionInfo =
        _$VideoBaseActionController.startAction(name: 'VideoBase.addVideo');
    try {
      return super.addVideo(video, callback);
    } finally {
      _$VideoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeVideo(Video video) {
    final _$actionInfo =
        _$VideoBaseActionController.startAction(name: 'VideoBase.removeVideo');
    try {
      return super.removeVideo(video);
    } finally {
      _$VideoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listVideos: ${listVideos}
    ''';
  }
}
