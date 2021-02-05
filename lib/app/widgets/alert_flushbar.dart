import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlushBarAlert extends StatelessWidget {
  final String title;
  final String message;

  const FlushBarAlert({Key key, @required this.title, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flushbar(
        title: title,
        message: message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error_outline,
          color: Colors.black,
        ),
      )..show(context),
    );
  }
}
