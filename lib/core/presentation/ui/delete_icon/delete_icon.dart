import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteIcon extends StatelessWidget {
  final void Function() action;

  const DeleteIcon({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Icon(
        Icons.delete,
        size: 20.r,
        color: Colors.red,
      ),
    );
  }
}
