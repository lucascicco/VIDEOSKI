import 'package:flutter/material.dart';

class Video {
  final String url;
  bool favorite;

  Video({@required this.url, this.favorite = false});
}
