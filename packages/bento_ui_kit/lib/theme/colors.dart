import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyColor {
  static final buttonText = Color(0xffF8F8F8).withOpacity(0.7);
  static final buttonFill = Color(0xff282828).withOpacity(.7);
  static final buttonBorderFallBack = Color.fromRGBO(255, 255, 255, 0.40);
  static final buttonShadow = BoxShadow(
    color: Color.fromRGBO(248, 248, 248, 0.06),
    offset: Offset(2, 4),
  );
  static final buttnBlur = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50, tileMode: TileMode.clamp),
  );

  static final borderGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.4),
      Color.fromRGBO(255, 255, 255, 0),
      Color.fromRGBO(255, 255, 255, 0),
      Color.fromRGBO(255, 255, 255, 0.3),
    ],
    stops: [0.1419, 0.5059, 0.6879, 1],
  );
}
