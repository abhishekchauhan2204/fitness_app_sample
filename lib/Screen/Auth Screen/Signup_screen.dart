import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/Signin_screen.dart';
import 'package:fitness_app_sample/Screen/HomeScreen/HomeScreen.dart';
import 'package:fitness_app_sample/Widget%20common/Alertbox.dart';
import 'package:fitness_app_sample/Widget%20common/CustomTextfield.dart';
import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var email = TextEditingController();

  var password = TextEditingController();
  bool _isloading = false;
  var username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usercredentials(String email, String password, String username) async {
      setState(() {
        _isloading = true;
      });
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        customalertbox(context, "please fill the requried fields", () {
          setState(() {
            _isloading = false;
          });
        });
      } else {
        UserCredential? usercredential;
        try {
          usercredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(usercredential.user!.uid)
              .set({
            'username': username,
            'email': email,
          });
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ));
        } on FirebaseAuthException catch (ex) {
          customalertbox(context, ex.code.toString(), () {});
        } finally {
          setState(() {
            _isloading = false;
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width * .85,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create your \nAccount",
                        style: tb35(rang: Colors.white),
                      ),
                      SizedBox(height: 30),
                      Gesturetextfield(
                        tohide: false,
                        controller: username,
                        text: "enter your username",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Gesturetextfield(
                          tohide: false,
                          controller: email,
                          text: "enter your email",
                          iconData: Icons.email),
                      SizedBox(
                        height: 10,
                      ),
                      Gesturetextfield(
                          tohide: true,
                          controller: password,
                          text: "enter your password",
                          iconData: Icons.remove_red_eye_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              usercredentials(
                                email.text.toString(),
                                password.text.toString(),
                                username.text.toString(),
                              );
                              print(username);
                            },
                            child: _isloading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Signup',
                                    style: tb20(),
                                  )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Text
                          Text(
                            "Already have a Account?",
                            style: tb20(rang: Colors.white54),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //Login button
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SigninScreen();
                                },
                              ));
                            },
                            child: Text(
                              'Log in',
                              style: tb20(
                                rang: Color(0xFFF1E8B8),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 49,
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
