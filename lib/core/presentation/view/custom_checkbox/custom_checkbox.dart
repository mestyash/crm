import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;
  final void Function() action;

  const CustomCheckbox({
    super.key,
    required this.isSelected,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: AnimatedContainer(
        width: 20.r,
        height: 20.r,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 1.r,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        alignment: Alignment.center,
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 200),
          child: Icon(
            Icons.check,
            size: 15.r,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
