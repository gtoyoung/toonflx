import 'dart:async';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Color(0xffe7626c),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xff232b55),
          ),
        ),
        cardColor: const Color(0xfff4eddb),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const fixTime = 1500;
  int totalSeconds = fixTime;
  int totalPomodoros = 0;
  late Timer timer;
  bool isPlay = true;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;

      if (totalSeconds == 0) {
        totalPomodoros = totalPomodoros + 1;

        totalSeconds = fixTime;
        isPlay = true;
        timer.cancel();
      }
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  void onPause() {
    timer.cancel();
    setState(() {
      isPlay = !isPlay;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isPlay = !isPlay;
    });
  }

  void onReset() {
    setState(() {
      totalSeconds = fixTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: isPlay
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: onStartPressed,
                        icon: const Icon(
                          Icons.play_circle_outlined,
                        ),
                      ),
                      IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: onReset,
                        icon: const Icon(
                          Icons.reset_tv_outlined,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: onPause,
                    icon: const Icon(
                      Icons.pause_circle_outlined,
                    )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 58,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
