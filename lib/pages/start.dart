import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/services/gane%20logic.dart';

import '../components/btn.dart';
import 'game.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.65],
              colors: [
                Colors.blue,
                Colors.yellow,
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[                    const SizedBox(height: 60),


              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "XO Game",
                      style:  TextStyle(
                          color: Colors.white,
                          fontSize: 65,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DancingScript'),
                    ),
const SizedBox(height: 20,),
Image.asset("assets/tic.png",height: 200,width: 200,)                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
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
                            builder: (context) => GamePage(
                              hi: 1,
                            ),
                          ),
                        );
                      },
                      height: 40,
                      width: 250,
                      borderRadius: 250,
                      color: Colors.white,
                      child: Text(
                        "single player".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Btn(
                      onTap: () {
                        // boardService.gameMode$.add(GameMode.Multi);
                        // soundService.playSound('click');

                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => GamePage(
                              hi: 2,
                            ),
                          ),
                        );
                      },
                      color: Colors.white,
                      height: 40,
                      width: 250,
                      borderRadius: 250,
                      child: Text(
                        "with a friend".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
