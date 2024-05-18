import 'package:fitness_app_sample/Screen/Auth%20Screen/Signin_screen.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/Signup_screen.dart';
import 'package:fitness_app_sample/Screen/HomeScreen/HomeScreen.dart';
import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';

class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF301934),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width *.6,
              ),
              Icon(Icons.fitness_center_sharp, size: 100, color: Colors.white),
              SizedBox(height: 30),
              Text(
                'Start your \nFitness Journey',
               style: tb30(rang: Colors.white54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ));
                    },
                    child: Text(
                      'Login',
                      style: tb20(rang: Colors.black),
                    )),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignupScreen(),));
                    },
                    child: Text(
                      'Register',
                      style: tb20(rang: Colors.black),
                    )),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
                child: Text('Continue as a guest',
                    style: tb25(rang: Colors.white54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
