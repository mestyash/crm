import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsCard extends StatelessWidget {
  final int lessonId;
  final String date;

  const LessonsCard({
    super.key,
    required this.lessonId,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 17.5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 7.5.r),
        decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: ProjectShadow.boxShadow1,
        ),
        child: Text(date, style: _textTheme.bodyText1),
      ),
    );
  }
}
