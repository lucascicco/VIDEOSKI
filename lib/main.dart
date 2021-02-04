import 'package:animationmusic/app/controller.dart';
import 'package:animationmusic/app/pages/video_homepage/video_homepage.dart';
import 'package:get_it/get_it.dart';
import './app/pages/video_render/video_render.dart';
import 'package:flutter/material.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<VideoController>(VideoController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VideoskiApp',
        theme: ThemeData(
          primaryColor: Colors.red[400],
          accentColor: Colors.grey[900],
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        initialRoute: VideoHomePage.routeName,
        routes: {
          VideoHomePage.routeName: (ctx) => VideoHomePage(),
          YoutubeRender.routeName: (ctx) => YoutubeRender(),
        });
  }
}
