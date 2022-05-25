import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';
class ColorGame extends StatefulWidget {

  @override
  _ColorGameState createState() => _ColorGameState();
}

class _ColorGameState extends State<ColorGame> {
  bool _gameOver = false;

  int _seconds = 60;
  int _level = 1;
  int _bestLevel = 1;

  int _crossAxisCount = 3;

  int? _diffIndex;
  Color? _diffColor;
  Color? _color;

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  void _updateData() async {
    final crossAxisCount = math.min(10, ((_level + 5) / 2).floor());

    final rand = math.Random();
    final diffIndex = rand.nextInt(crossAxisCount * crossAxisCount);
    final color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1);
    final diffColor = color.withOpacity(math.min(0.95, 0.5 + _level / 100));

    var prefs = await SharedPreferences.getInstance();
    var bestLevel = prefs.getInt('BEST') ?? 1;

    if (bestLevel < _level) {
      await prefs.setInt('BEST', _level);
      bestLevel = _level;
    }

    setState(() {
      _diffIndex = diffIndex;
      _color = color;
      _diffColor = diffColor;
      _crossAxisCount = crossAxisCount;
      _bestLevel = bestLevel;
    });
  }

  void _setGameOver() {
    setState(() {
      _seconds = 0;
      _gameOver = true;
    });
  }

  void _restart() {
    setState(() {
      _gameOver = false;
      _level = 1;
      _seconds = 60;
    });

    _updateData();
  }

  void _setTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
          (Timer t) {
        if (_seconds <= 0) {
          t.cancel();
          _setGameOver();
        } else {
          setState(() {
            _seconds = _seconds - 1;
          });
        }
      },
    );
  }

  void _onTimePressed() {
    if (_gameOver) {
      _restart();
    } else {
      _setGameOver();
    }
  }

  void _onColorPressed(int index) {
    if (!_gameOver && index == _diffIndex) {
      if (_level == 1) {
        _setTimer();
      }
      _updateData();
      setState(() {
        _level = _level + 1;
      });
    }
  }

  Widget _buildToolbar() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: InkWell(
              onTap: _onTimePressed,
              child: Container(

                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    const Radius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: _gameOver
                    ? const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 36,
                )
                    : Text(
                  _seconds.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(

              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
color: Colors.grey,                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            'LEVEL',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _level.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            'BEST',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _bestLevel.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquare() {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: GridView.count(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(2),
        crossAxisCount: _crossAxisCount,
        children: List.generate(
          _crossAxisCount * _crossAxisCount,
              (index) => _buildColorBox(index),
        ),
      ),
    );
  }

  Widget _buildColorBox(int index) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: RaisedButton(
        color: index != _diffIndex ? _color : _diffColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        onPressed: () {
          _onColorPressed(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
      gradient: const LinearGradient(
      begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.1, 0.65],
        colors: [
          Colors.red,
          Colors.deepPurple,

        ],
      ),
    ),

        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildToolbar(),
                _buildSquare(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}