import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key key}) : super(key: key);

  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  TextEditingController _addItemController = TextEditingController();

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
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: _addItemController,
                  onEditingComplete: () {
                    if (utube.hasMatch(_addItemController.text)) {
                      // start added
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
                            // active the animation //
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
            ]),
      ),
    );
  }
}
