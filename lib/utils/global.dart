import 'package:flutter/material.dart';

abstract class Global {
  static const appName = 'Just Chat';
  static final appTextTheme = TextTheme();

  static const Color primaryColor = Color.fromARGB(255, 63, 17, 177);
  static final appTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    textTheme: appTextTheme,
  );
}
