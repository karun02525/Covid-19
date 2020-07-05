import 'package:covid19_app/config/const.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/commom/commom.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: winWidth(context),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          new Space(),
          new Text(
            '加载中',
            style: TextStyle(color: mainTextColor),
          ),
        ],
      ),
    );
  }
}
