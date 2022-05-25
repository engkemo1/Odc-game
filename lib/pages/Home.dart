import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/pages/ColorGame/Home.dart';
import 'package:game/pages/start.dart';
import 'package:game/services/gane%20logic.dart';

import '../components/btn.dart';
import 'game.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.65],
              colors: [
                Colors.green,
                Colors.deepOrange,
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[                    const SizedBox(height: 60),

Container(
margin:const EdgeInsets.all(20) ,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  child:        Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        "Pick Your Game",
        style: const TextStyle(
            color: Colors.white,
            fontSize: 65,
            fontWeight: FontWeight.w700,
            fontFamily: 'DancingScript'),
      ),
      const SizedBox(height: 200,),
      Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Btn(
              onTap: () {
                // boardService.gameMode$.add(GameMode.Solo);
                // soundService.playSound('click');

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => StartPage(
                    ),
                  ),
                );
              },
              height: 40,
              width: 250,
              borderRadius: 250,
              color: Colors.white,
              child: Text(
                "Xo Game".toUpperCase(),
                style: TextStyle(
                    color: Colors.black.withOpacity(.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            Btn(
              onTap: () {

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ColorGame(
                    ),
                  ),
                );
              },
              color: Colors.white,
              height: 40,
              width: 250,
              borderRadius: 250,
              child: Text(
                "Color Game".toUpperCase(),
                style: TextStyle(
                    color: Colors.black.withOpacity(.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),

          ],
        ),


    ],
  )
)
            
            ],
          ),
        ),
      ),
    );
  }
}
