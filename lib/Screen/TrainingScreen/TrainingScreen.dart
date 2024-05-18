import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_sample/Screen/ProfileScreen/ProfileScreen.dart';
import 'package:fitness_app_sample/Screen/WorkoutScreen/FatBurnerHiit/FatburnerhiitScreen.dart';
import 'package:fitness_app_sample/Screen/WorkoutScreen/WarmupScreen/WarmUpScreen.dart';
import 'package:flutter/material.dart';
import '../../Widget common/Activity card.dart';

class TrainingScreen extends StatefulWidget {
  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {

  late  String _username = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }


  Future<void> _fetchUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _username = userDoc['username'] ?? 'Guest';
          _isLoading = false;
        });
      } else {
        // If no user is logged in, set to guest
        setState(() {
          _username = 'Guest';
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching username: $e');
      setState(() {
        _username = 'Guest';
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1B2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi!,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _isLoading
                          ? CircularProgressIndicator() // Show loading indicator while fetching
                          : Text(
                        _username.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF413D58),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/search.png',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/search.png'),
                          radius: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Schedule
              SizedBox(height: 40),
              Text(
                'Your Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Fitness Activity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              ActivityCard(
                title: 'WARMUP',
                subtitle: 'Run 02 km',
                buttonLabel: 'Start',
                voidCallback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WarmupScreen()));
                },
              ),
              SizedBox(height: 16),
              ActivityCard(
                title: 'FAT BURNER HIIT',
                subtitle: '10 reps, 3 sets with 20 sec rest',
                buttonLabel: 'Start',
                voidCallback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FatBurnerScreen(),));
                },
              ),SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
