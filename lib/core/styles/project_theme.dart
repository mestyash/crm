import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectMargin {
  static double contentTop = 30.h;
  static double contentHorizontal = 15.w;
  static double inputMargin = 24.h;
}

class ProjectShadow {
  static List<BoxShadow> boxShadow1 = [
    BoxShadow(
      blurRadius: 22,
      offset: Offset(4, 4),
      color: Color.fromARGB(16, 18, 46, 101),
    )
  ];
}

class ProjectColors {
  static const primary = Color(0xFF33452C);
  static const secondary = Color(0xFFA7BE8F);
}

class ProjectThemes {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: ProjectColors.primary,
    canvasColor: Color.fromARGB(255, 233, 233, 233),
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: ProjectColors.secondary,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        height: 0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: Color.fromARGB(255, 54, 50, 50),
      backgroundColor: ProjectColors.secondary,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ProjectColors.secondary,
    ),
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
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
        height: 1.18,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat',
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        height: 1.44,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        height: 1.625,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat',
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        height: 1.25,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      ),
      // input hint
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.364,
        fontFamily: 'Montserrat',
      ),
      // input text
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.42,
        fontFamily: 'Montserrat',
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        height: 1.53,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
        height: 1.38,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      labelLarge: TextStyle(
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
