import 'package:fitness_app_sample/Screen/WorkoutScreen/FatBurnerHiit/Fatburnerworkout/Fatburnerworkout.dart';
import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';

import '../../../miscellaneous/Listcommon.dart';
import 'exercisecard.dart';

class FatBurnerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1B2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                        size: 20,
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  Text(
                    'FAT BURNER HIIT BEGINNER',
                    style: tb20(rang: Colors.white70),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 20),
              Text(
                'High-intensity  fat burning workouts with afterburn effect. Keep burning calories even after training!',
                style: tb20(rang: Colors.white70),
              ),
              SizedBox(height: 20),
              Text(
                '14 mins • Beginner',
                style: tb20(rang: Colors.white70),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: workoutlist.length,
                  itemBuilder: (context, index) {
                    return WorkoutTile(
                      name: workoutlist[index],
                      duration: '00.30',
                    );
                  },
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF5C469),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FatburnerworkoutScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Start",
                      style: tb18(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              )
            ],
          ),
        ),
      ),
    );
  }
}
