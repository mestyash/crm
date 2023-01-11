import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppSnackBarState {
  success,
  failure,
}

class AppSnackBar {
  final String text;
  final AppSnackBarState state;

  AppSnackBar({required this.text, required this.state});

  static SnackBar success({required String text}) {
    return AppSnackBar(
      text: text,
      state: AppSnackBarState.success,
    )._getWidget();
  }

  static SnackBar failure({required String text}) {
    return AppSnackBar(
      text: text,
      state: AppSnackBarState.failure,
    )._getWidget();
  }

  SnackBar _getWidget() {
    IconData icon;
    Color? color;

    switch (state) {
      case AppSnackBarState.success:
        icon = Icons.check;
        color = Colors.green;
        break;

      case AppSnackBarState.failure:
        icon = Icons.priority_high;
        color = Colors.red;
        break;
    }

    return SnackBar(
      duration: Duration(seconds: 3, milliseconds: 500),
      content: Row(
        children: [
          Container(
            width: 22.r,
            height: 22.r,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 14.r,
              color: color,
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    );
  }
}
