import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopWatchApp());
}

class StopWatchApp extends StatefulWidget {
  const StopWatchApp({super.key});

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(
      () {
        started = false;
      },
    );
  }

  void reset() {
    timer!.cancel();
    setState(
      () {
        seconds = 0;
        minutes = 0;
        hours = 0;

        digitSeconds = '00';
        digitMinutes = '00';
        digitHours = '00';

        started = false;
        laps = [];
      },
    );
  }

  void addLaps() {
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinuts = 0;
      int localHours = 0;

      if (localSeconds > 59) {
        if (localMinuts > 59) {
          localHours++;
          localMinuts = 0;
        } else {
          localMinuts++;
          localSeconds = 0;
        }
      }
      setState(() {
        hours = localHours;
        minutes = localMinuts;
        seconds = localSeconds;
        digitSeconds = (seconds >= 10 ? '$seconds' : '0$seconds');
        digitMinutes = (minutes >= 10 ? '$minutes' : '0$minutes');
        digitHours = (hours >= 10 ? '$hours' : '0$hours');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1C2757),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Stop Watch',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: Text(
                    '$digitHours:$digitMinutes:$digitSeconds',
                    style: const TextStyle(
                        fontSize: 82,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFF323F68),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Lap ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${laps[index]}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                          onPressed: () {
                            (!started) ? start() : stop();
                          },
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue),
                          ),
                          child: Text(
                            (!started) ? 'Start' : 'Pause',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: const Icon(Icons.flag),
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: RawMaterialButton(
                          fillColor: Colors.blue,
                          onPressed: () {
                            reset();
                          },
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
