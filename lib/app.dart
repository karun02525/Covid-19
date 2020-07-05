import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:covid19_app/config/config.dart';
import 'package:covid19_app/config/const.dart';
import 'package:covid19_app/pages/root/root_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      navigatorKey: navGK,
      theme: ThemeData(
        indicatorColor: appBarColor,
        scaffoldBackgroundColor: bgColor,
        hintColor: Colors.grey.withOpacity(0.3),
        splashColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      home: new RootPage(),
    );
  }
}
