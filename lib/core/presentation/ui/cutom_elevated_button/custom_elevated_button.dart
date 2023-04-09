import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? primaryColor;
  final double? pVertical;
  final double? borderRadius;
  final double width;

  final String text;
  final void Function()? onTap;

  CustomElevatedButton({
    Key? key,
    this.primaryColor,
    this.pVertical,
    this.borderRadius,
    this.width = double.infinity,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    // styles
    final _paddingVertical = EdgeInsets.symmetric(vertical: pVertical ?? 10.h);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
      child: Container(
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: _paddingVertical,
              width: width,
              alignment: Alignment.center,
              child: Text(
                text,
                style: _textTheme.bodyText1?.copyWith(
                  height: 0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            highlightColor: Colors.black.withOpacity(0.2),
            splashColor: Colors.black.withOpacity(0.05),
          ),
          color: Colors.transparent,
        ),
        color: onTap != null
            ? _theme.primaryColor
            : _theme.appBarTheme.backgroundColor,
      ),
    );
  }
}
