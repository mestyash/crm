import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final _background = Theme.of(context).appBarTheme.backgroundColor;

    return AppBar(
      backgroundColor: _background,
      title: Text(
        title.toUpperCase(),
      ),
      actions: [
        ...actions,
        SizedBox(width: 10.w),
      ],
    );
  }
}
