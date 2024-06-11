

import 'package:fitness_app_sample/Screen/ProfileScreen/ProfileScreen.dart';
import 'package:fitness_app_sample/Screen/TrainingScreen/TrainingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ActivityScreen/ActivityScreen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentindex = 0;
  var Colorindex = 0;

  var body = [
    TrainingScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  var item = [
    BottomNavigationBarItem(
        icon: Image.asset(height: 35,"assets/images/categories.png"), label: ""),
    BottomNavigationBarItem(
        icon: Image.asset("assets/images/activity_tab.png"), label: ""),
    BottomNavigationBarItem(
        icon: Image.asset("assets/images/profile_tab.png"), label: ""),
  ];

  var rang = [Color(0xFF1C1B2E), Color(0xFF1C1B2E), Color(0xFF1C1B2E)];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body.elementAt(currentindex),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          onTap: (value) {
            setState(() {
              currentindex = value;
              Colorindex = value;
            });
          },
          currentIndex: currentindex,
          backgroundColor: rang.elementAt(Colorindex),
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          items: item),
    );
  }
}
