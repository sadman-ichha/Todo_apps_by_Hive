// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_apps/home_screen.dart';
import 'package:todo_apps/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());

  Box userBox = await Hive.openBox("todo-list");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(400, 926),
      builder: (_, ctx) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),

        );
      },
    );
  }
}
