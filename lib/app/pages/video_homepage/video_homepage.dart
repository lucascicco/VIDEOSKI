import 'package:animationmusic/app/controller.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:get_it/get_it.dart';
import '../../models/video_model.dart';
import '../video_render/video_render.dart';

class VideoHomePage extends StatefulWidget {
  static const routeName = '/';
  const VideoHomePage({Key key}) : super(key: key);

  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  final controller = GetIt.I<VideoController>();

  TextEditingController _addItemController = TextEditingController();

  bool animated = false;

  void toNext() async {
    controller.addVideo(Video(url: _addItemController.text));

    setState(() {
      animated = true;
    });

    await Future.delayed(const Duration(milliseconds: 3), () {
      Navigator.of(context).pushReplacementNamed(YoutubeRender.routeName,
          arguments: Video(url: _addItemController.text));
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
          return Container(
            child: AnimatedPositioned(
              curve: Curves.easeInExpo,
              top: animated ? 0 : constraits.maxHeight,
              duration: Duration(seconds: 3),
              child: AnimatedContainer(
                width: animated ? double.infinity : constraits.maxWidth * 0.4,
                duration: Duration(seconds: 3),
                child: TextField(
                  controller: _addItemController,
                  onEditingComplete: () {
                    if (utube.hasMatch(_addItemController.text)) {
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
                      focusedBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.add, size: 40, color: Colors.red),
                        onTap: () {
                          if (utube.hasMatch(_addItemController.text)) {
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
          );
        },
      ),
    );
  }
}
