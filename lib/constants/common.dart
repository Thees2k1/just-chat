import 'package:flutter/material.dart';

abstract class Global {
  static const appName = 'Just Chat';
  static final appTextTheme = TextTheme();

  static const Color primaryColor = Color.fromRGBO(110, 164, 187, 1);
  static final appTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    textTheme: appTextTheme,
  );
}

abstract class Assets {
  // ignore: constant_identifier_names
  static const _IMAGE_PREFIX ='assets/images/';
  static const chatImage ='${_IMAGE_PREFIX}chat.png';
}
