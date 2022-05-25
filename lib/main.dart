import 'package:flutter/material.dart';
import 'package:game/pages/ColorGame/Home.dart';
import 'package:game/pages/Home.dart';
import 'package:game/pages/Splash%20Screen.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

