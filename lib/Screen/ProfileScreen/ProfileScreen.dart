import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_sample/Widget%20common/togglebutton.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/GuestScreen.dart';
import 'package:fitness_app_sample/Screen/ProfileScreen/profileinfo.dart';
import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("assets/images/profile_tab.png"),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 5),
            Text(
             "172 cm",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              " 63KG",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  ProfileInfo(
                      title: "Account Informations", icon: Icons.person),
                  Divider(
                    color: Colors.white12,
                  ),
                  ProfileInfo(
                      title: "Notifications",
                      icon: Icons.notifications,
                      trailing: Togglebutton(
                        voidCallback: () {},
                      )),
                  Divider(color: Colors.white10),
                  InkWell(splashColor: Colors.black,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GuestScreen()));
                      },
                      child: ProfileInfo(
                          title: "Sign out",
                          icon: Icons.logout,
                          trailing: Text("Medium"))),
                ],
              ),
            ),
            Spacer(),
            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Support",
                    style: tb25(rang: Colors.white),
                  ),
                )),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: ProfileInfo(
                    title: "Terms Of Service", icon: Icons.description)),
          ],
        ),
      ),
    );
  }
}
