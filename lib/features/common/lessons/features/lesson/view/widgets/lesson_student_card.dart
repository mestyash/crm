import 'package:crm/core/presentation/ui/custom_checkbox/custom_checkbox.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonStudentCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final void Function() action;

  const LessonStudentCard({
    super.key,
    required this.name,
    required this.isSelected,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 7.5.r),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          border: Border.all(width: 0.4.r),
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: ProjectShadow.boxShadow1,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: textTheme.bodyLarge?.copyWith(height: 0),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            SizedBox(width: 5.w),
            CustomCheckbox(isSelected: isSelected, action: action)
          ],
        ),
      ),
    );
  }
}
