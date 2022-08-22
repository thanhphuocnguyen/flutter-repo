import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/containers/homepage.dart';

class IOSHome extends StatelessWidget {
  const IOSHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "DeliMeals",
      theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
          scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray),
      home: Scaffold(
        appBar: CupertinoNavigationBar(),
        body: MyHomePage(),
      ),
    );
  }
}
