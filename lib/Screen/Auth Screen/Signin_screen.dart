import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/ForgetpassScreen.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/Signup_screen.dart';
import 'package:fitness_app_sample/Screen/HomeScreen/HomeScreen.dart';
import 'package:fitness_app_sample/Widget%20common/Alertbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widget common/CustomTextfield.dart';
import '../../Widget common/textstyle.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var email = TextEditingController();

  var password = TextEditingController();

  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    usercredentials(String email, String password) async {
      setState(() {
        _isloading = true;
      });
      if (email == "" && password == "") {
        return customalertbox(
            context, "please fill the required fields", () {setState(() {
              _isloading= false;
            });});
      }
      else {
        UserCredential ? usercredential;
        try {
          usercredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email, password: password).then((value) =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen(),)));
        } on FirebaseAuthException catch(e){
          customalertbox(context, e.code.toString(), (){});
        }finally {
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
      child: Scaffold(backgroundColor: Color(0xFF301934),
        body: SafeArea(
          child: Center(
              child: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * .85,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login to your \nAccount",
                        style: tb35(rang: Colors.white),
                      ),
                      SizedBox(
                          height: 30
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
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ForgetpasswordScreen();
                              },));
                          },
                          child: Text(
                              'Forgot Password?',
                              style: tb18(rang: Colors.white)
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity, alignment: Alignment.center,
                        child: ElevatedButton(onPressed: () {
                         usercredentials(email.text.toString(), password.text.toString());
                        }, child: _isloading? CircularProgressIndicator():Text("Login", style: tb20(),)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Text
                          Text(
                            "Don't have a Account?",
                            style: tb18(rang: Colors.white54),
                          ),
                          SizedBox(width: 5,),
                          //Login button
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignupScreen();
                                  },));
                            },
                            child: Text('Register now',
                              style: tb18(
                                rang: Color(0xFFF1E8B8),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 49,)
                    ]),
              )),
        ),
      ),
    );
  }
}
