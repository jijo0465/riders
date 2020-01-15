import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riders/screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Riders',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen.navigate(
        name: 'assets/splash.flr',
        fit: BoxFit.fill,
        next: (context) => MyHomePage(title: 'Riders'),
        until: () => Future.delayed(Duration(seconds: 2,milliseconds: 300)),
        startAnimation: 'splash',
      ),
    );
  }
}


