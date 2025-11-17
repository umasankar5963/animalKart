import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xffF6F8FA);
  static const card = Colors.white;
  static const teal = Color(0xff1D6F6A);
  static const softRed = Color(0xffFDECEC);
  static const softYellow = Color(0xffFFF6D6);
  static const textDark = Color(0xff1D1D1F);
  static const textGrey = Color(0xff6A6A6A);
}

class AppShadow {
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];
}

class AppRadius {
  static BorderRadius card = BorderRadius.circular(22);
}
