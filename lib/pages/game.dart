import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/o.dart';
import '../components/x.dart';
import '../services/gane logic.dart';
import '../theme/constant.dart';
import 'start.dart';

class GamePage extends StatefulWidget {
  final int? hi;

  GamePage({Key? key, this.hi}) : super(key: key);

  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  String activePlayer = "X";
  bool gameOver = false;
  String result = "";
  Game game = Game();
  int winnerX = 0;
  int winner0 = 0;
  int turns = 0;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();

    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _centerController,
                    blastDirection: pi / 2,
                    maxBlastForce: 10,
                    minBlastForce: 2,

                    emissionFrequency: 0.03,
                    numberOfParticles: 10,

                    // particles will pop-up up
                    gravity: 0,
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          Player.playerO.clear();
                          Player.playerX.clear();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => StartPage()));
                        },
                        color: Colors.black87,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Material(
                        elevation: 5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                            child: Text(
                          "$winnerX",
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    X(35, 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "Player",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 400,
                  child: GridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => InkWell(
                              onTap: gameOver
                                  ? null
                                  : () {
                                      _onTap(index);
                                    },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Text(
                                      Player.playerX.contains(index)
                                          ? "X"
                                          : Player.playerO.contains(index)
                                              ? "O"
                                              : "",
                                      style: const TextStyle(
                                          color: Colors.yellow, fontSize: 50),
                                    ),
                                  )),
                            )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      O(35, MyTheme.green),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          "Player",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Material(
                          elevation: 5,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                              child: Text(
                            "$winner0",
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.repeat),
                        onPressed: () {
                          setState(() {
                            gameOver = false;
                            turns = 0;
                            result = "";
                            Player.playerO = [];
                            Player.playerX = [];
                          });
                        },
                        color: Colors.black87,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          )),
    );
  }

  _onTap(int index) async {
    if (Player.playerX.isEmpty ||
        !Player.playerX.contains(index) ||
        Player.playerO.isEmpty ||
        !Player.playerO.contains(index)) {
      game.playGame(index, activePlayer);
      UpdateState();

      if (widget.hi == 1 && gameOver == false) {
        await game.autoPlay(activePlayer);
        UpdateState();
      }
    }
  }

  void UpdateState() {
    setState(() {
      activePlayer = (activePlayer == "X") ? "O" : "X";
      turns++;
    });
    String win = game.checkWinner();
    if (win == "draw" && turns == 9) {
      result = "It\'s Draw!";
      Alert(
        context: context,
        title: result,
        buttons: [
          DialogButton(
            child: const Text(
              "COOL",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else if (win == "X") {
      _centerController.play();

      gameOver = true;
      result = "Player X is the Winner";
      Alert(
        context: context,
        title: result,
        buttons: [
          DialogButton(
            child: const Text(
              "COOL",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      setState(() {
        winnerX++;
      });
    } else if (win == "O") {
      gameOver = true;

      _centerController.play();
      result = "Player O is the Winner";
      Alert(
        context: context,
        title: result,
        buttons: [
          DialogButton(
            child: const Text(
              "COOL",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      setState(() {
        winner0++;
      });
    }
  }
}
