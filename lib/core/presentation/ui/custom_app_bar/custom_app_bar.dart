import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
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
    );
  }
}
