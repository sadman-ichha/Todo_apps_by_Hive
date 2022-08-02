
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_apps/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

     Timer(
        Duration(seconds: 4), ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen(),)),

    );
    return Scaffold(
      body: Center(
        child:Container(
          height: 150.0,
            width: 150.0,
            child: Image.asset('assets/Splash.png')),
      ),
    );
  }
}
