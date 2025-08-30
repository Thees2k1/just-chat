import 'package:flutter/material.dart';
import 'package:just_chat/screens/home.dart';
import 'package:just_chat/utils/global.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.appName,
      theme: Global.appTheme,
      home: HomeScreen(),
    );
  }
}
