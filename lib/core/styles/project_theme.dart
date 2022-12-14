import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectMargin {
  static double contentTop = 30.h;
  static double contentHorizontal = 15.w;
}

class ProjectThemes {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.lightBlue[800],
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        height: 1.44,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xFF21262E),
        fontSize: 12.sp,
        height: 0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
      errorStyle: TextStyle(
        fontSize: 10.sp,
        height: 0,
        color: Colors.red,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.sp),
      ),
      fillColor: Color(0xFFF7F7F7),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 13.r, vertical: 11.r),
      isDense: true,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
        height: 1.18,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat',
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        height: 1.44,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        height: 1.625,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat',
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        height: 1.25,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      // input hint
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.364,
        fontFamily: 'Montserrat',
      ),
      // input text
      caption: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.42,
        fontFamily: 'Montserrat',
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        height: 1.53,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
        height: 1.38,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      button: TextStyle(
        color: Colors.black,
        fontSize: 13.sp,
        height: 1.538,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    ),
  );
  static final darkTheme = ThemeData.dark();
}
