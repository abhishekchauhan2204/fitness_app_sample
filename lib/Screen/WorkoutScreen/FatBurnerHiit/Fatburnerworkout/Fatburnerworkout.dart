import 'dart:async';
import 'package:fitness_app_sample/Screen/WorkoutScreen/WarmupScreen/warmupinfo.dart';
import 'package:fitness_app_sample/miscellaneous/Listcommon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';


class FatburnerworkoutScreen extends StatefulWidget {


  @override
  State<FatburnerworkoutScreen> createState() => _FatburnerworkoutScreenState();
}

class _FatburnerworkoutScreenState extends State<FatburnerworkoutScreen> {
  bool isTimerRunning = false;
  int secondsElapsed = 0;
  int workoutIndex = 0;
  Timer? timer;
  late DateTime startTime;
  final int totalWorkoutDuration = 1 * workoutlist.length; // Total workout duration in seconds (10 minutes)


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
        if (secondsElapsed % 1 == 0) {
          workoutIndex = (workoutIndex + 1) % workoutlist.length;
        }
        if (secondsElapsed >= totalWorkoutDuration) {
          pauseTimer();
          showCompletionDialog();
        }
      });

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
      workoutIndex = 0;
    });
  }



  String getFormattedTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  Duration getTimeRemaining() {
    return Duration(seconds: totalWorkoutDuration - secondsElapsed);
  }


  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("TASK COMPLETED"),
          content: Text("YOU HAVE COMPLETED FAT BURNER HIIT WORKOUT!!"),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<WarmupStateHiit>(context, listen: false).completeFatburner();
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
                              "Fat Burner",
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
                                    "HIIT",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Image.asset("assets/images/choose_workout.png",color: Colors.white,scale: .8,)
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
                    label: "Workoutname",
                    value: workoutlist[workoutIndex],
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
