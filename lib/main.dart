import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_sample/Screen/Auth%20Screen/GuestScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyDZxfh0dlBVYMR07nucsYtznMSZNmTYTPQ",
      appId: "1:153869544696:android:5a77f79642482735841f0d",
      messagingSenderId: "153869544696",
      projectId:"fitness-crunch-af447")):
  Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WarmupState()),
          ChangeNotifierProvider(create: (_) => FatBurnerHiit()),
        ],
        child: MaterialApp(
            title: 'Fitness Crunch',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF301934)),
              useMaterial3: true,
            ),
            home: GuestScreen()));
  }
}
