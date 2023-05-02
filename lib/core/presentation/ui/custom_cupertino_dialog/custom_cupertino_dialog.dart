import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void CustomCupertinoDialog({
  required BuildContext context,
  required String title,
  String? content,
  required String firstActionText,
  required void Function() firstAction,
  required String secondActionText,
  required void Function() secondAction,
  bool isRedSecondAction = true,
}) {
  final _theme = Theme.of(context);
  final _textTheme = _theme.textTheme;

  showDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        title,
        style: _textTheme.titleSmall?.copyWith(height: 0),
      ),
      content: Visibility(
        visible: content != null,
        child: Text(
          content ?? '',
          style: _textTheme.bodyMedium?.copyWith(height: 0, fontSize: 11.sp),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            firstActionText,
            style: _textTheme.bodyLarge?.copyWith(
              height: 0,
              color: _theme.primaryColor,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            secondAction();
          },
          child: Text(
            secondActionText,
            style: _textTheme.bodyLarge?.copyWith(
              height: 0,
              color: isRedSecondAction ? Colors.red : null,
            ),
          ),
        ),
      ],
    ),
  );
}
