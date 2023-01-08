import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData buttonIcon;
  final void Function() action;

  const CustomFloatingActionButton({
    super.key,
    this.buttonIcon = Icons.add,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return SizedBox(
      width: 46.r,
      height: 46.r,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: action,
        backgroundColor: _theme.primaryColor,
        child: Icon(
          buttonIcon,
          size: 30.r,
          color: _theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
