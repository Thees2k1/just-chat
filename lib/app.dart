import 'package:flutter/material.dart';
import 'package:just_chat/constants/common.dart';
import 'package:just_chat/utils/router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Global.appName,
      theme: Global.appTheme,
      routerConfig: appRouter,
    );
  }
}
