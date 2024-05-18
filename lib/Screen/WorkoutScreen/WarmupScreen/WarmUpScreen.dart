import 'dart:async';
import 'package:fitness_app_sample/Screen/WorkoutScreen/WarmupScreen/warmupinfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';



class WarmupScreen extends StatefulWidget {

  @override
  State<WarmupScreen> createState() => _WarmupScreenState();
}

class _WarmupScreenState extends State<WarmupScreen> {
  bool isTimerRunning = false;
  int secondsElapsed = 0;
  Timer? timer;
  late DateTime startTime;
  final double speedKmPerSecond =
      0.13461 / 60; // Average speed in km per second
  final double targetDistance = .11; // Target distance in KM

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    startTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsElapsed++;
      });
      if (calculateDistance() >= targetDistance) {
        timer?.cancel();
        showCompletionDialog();
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      secondsElapsed = 0;
      isTimerRunning = false;
    });
  }

  double calculateDistance() {
    return speedKmPerSecond * secondsElapsed;
  }

  String getFormattedTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  Duration getTimeRemaining() {
    double distanceCovered = calculateDistance();
    double distanceRemaining = targetDistance - distanceCovered;
    double secondsRemaining = distanceRemaining / speedKmPerSecond;
    return Duration(seconds: secondsRemaining.toInt());
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Completed"),
          content: Text("You have completed the 2 KM run!"),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<WarmupState>(context, listen: false).completeWarmup();

                Navigator.pop(context); // Close the alert dialog
                Navigator.pop(context);// Pop the WarmupScreen
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double distanceCovered = calculateDistance();
    Duration timeRemaining = getTimeRemaining();

    return Scaffold(
      backgroundColor: Color(0xFF1C1B2E),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                      size: 50,
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "WarmUp",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Run 2 KM",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Icon(
                            size: 60,
                            Icons.directions_run,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              '${(secondsElapsed ~/ 60).toString().padLeft(2, '0')}:${(secondsElapsed % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white, fontSize: 60),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  WarmUpinfo(
                    label: "Km",
                    value: distanceCovered.toStringAsFixed(2),
                  ),
                  WarmUpinfo(
                    label: "Started At",
                    value: isTimerRunning
                        ? getFormattedTime(startTime)
                        : "--:--:--",
                  ),
                  WarmUpinfo(
                    label: "Time Remaining",
                    value: isTimerRunning
                        ? '${timeRemaining.inMinutes}:${(timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}'
                        : "--:--",
                  ),
                  WarmUpinfo(
                    label: "Calories",
                    value: "", // Add calories calculation if needed
                  ),
                  IconButton(
                    icon: Icon(
                      isTimerRunning ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      if (isTimerRunning) {
                        pauseTimer();
                      } else {
                        startTimer();
                      }
                      setState(() {
                        isTimerRunning = !isTimerRunning;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
