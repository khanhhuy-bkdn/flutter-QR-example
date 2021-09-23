import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingCircularProcess extends StatefulWidget {
  @override
  _LoadingCircularProcessState createState() => _LoadingCircularProcessState();
}

class _LoadingCircularProcessState extends State<LoadingCircularProcess> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
