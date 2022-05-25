import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:game/pages/Home.dart';
import 'package:game/pages/start.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/xo.png',
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.rotationTransition,
    );

  }
}
