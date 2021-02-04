import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:get_it/get_it.dart';
import '../../controller.dart';
import '../../models/video_model.dart';
import '../video_render/video_render.dart';

class VideoHomePage extends StatefulWidget {
  static const routeName = '/';
  const VideoHomePage({Key key}) : super(key: key);

  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  final controller = GetIt.I.get<VideoController>();

  TextEditingController _addItemController = TextEditingController();

  int duration = 1;

  bool animationType1 = false;
  bool animationType2 = false;

  void toNext() async {
    Video video = Video(url: _addItemController.text);

    setState(() {
      animationType1 = true;
    });

    controller.addVideo(video);

    await Future.delayed(Duration(seconds: duration), () {
      Navigator.of(context)
          .pushReplacementNamed(YoutubeRender.routeName, arguments: video);
    });
  }

  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraits) {
          return Stack(
            children: <Widget>[
              AnimatedPositioned(
                top: animationType1 ? constraits.maxHeight : 0,
                duration: Duration(seconds: duration),
                curve: Curves.easeOut,
                child: Container(
                  width: constraits.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _addItemController,
                      onEditingComplete: () {
                        if (utube.hasMatch(_addItemController.text)) {
                          FocusScope.of(this.context).unfocus();
                          toNext();
                        } else {
                          FocusScope.of(this.context).unfocus();
                          _addItemController.clear();
                          Flushbar(
                            title: 'Link Inválido',
                            message: 'Digite um link correto',
                            duration: Duration(seconds: 3),
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.black,
                            ),
                          )..show(context);
                        }
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Link da URL',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.add, size: 40, color: Colors.red),
                            onTap: () {
                              if (utube.hasMatch(_addItemController.text)) {
                                FocusScope.of(this.context).unfocus();
                                toNext();
                              } else {
                                FocusScope.of(this.context).unfocus();
                                _addItemController.clear();
                                Flushbar(
                                  title: 'Link Inválido',
                                  message: 'Digite um link correto',
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Colors.black,
                                  ),
                                )..show(context);
                              }
                            },
                          )),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
