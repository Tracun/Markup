import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/splashscreen.jpeg'), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
