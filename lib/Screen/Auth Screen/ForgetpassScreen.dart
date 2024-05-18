import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/GuestScreen.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/Signin_screen.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/Signup_screen.dart';
import 'package:fitness_app_sample/Widget%20common/CustomTextfield.dart';
import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widget common/Alertbox.dart';

class ForgetpasswordScreen extends StatefulWidget {
  @override
  State<ForgetpasswordScreen> createState() => _ForgetpasswordScreenState();
}

class _ForgetpasswordScreenState extends State<ForgetpasswordScreen> {
  var Forgetpassword = TextEditingController();

  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    usercredentials(String Forgetpassword,) async {

      setState(() {
        _isloading = true;
      });

      if (Forgetpassword.isEmpty) {
        customalertbox(context, "Please fill the required fields", () {
          setState(() {
            _isloading = false;
          });
        });
      } else {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: Forgetpassword.toString(),
          );
          customalertbox(context, "Password reset link sent!", () {
            setState(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GuestScreen(),));
              _isloading = false;

            });
          });
        } on FirebaseAuthException catch (e) {
          customalertbox(context, "An error occurred: ${e.code.toString()}", () {
            setState(() {
              _isloading = false;
            });
          });
        }
      }
    }


  return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF301934),
          body: SafeArea(
              child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .90,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Forget Password",
                      style: tb35(rang: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "Don't worry! It occurs.Please enter the email address linked with your Account",
                        style: tb18(rang: Colors.white54)),
                    SizedBox(
                      height: 30,
                    ),
                    Gesturetextfield(
                        tohide: false,
                        controller: Forgetpassword,
                        text: "enter your email"),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          usercredentials(Forgetpassword.text.toString());
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.infinity,
                            child: _isloading?CircularProgressIndicator():Text(
                              "Send link",
                              style: tb25(),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember Password?",
                          style: tb20(rang: Colors.white54),
                        ),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SigninScreen();
                          },));
                        }, child: Text("Login",style: tb20(rang: Color(0xFFF1E8B8)),))
                      ],
                    )
                  ]),
            ),
          ))),
    );
  }
}

