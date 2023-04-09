import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsCard extends StatelessWidget {
  const GroupsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Название Группы',
            style: _textTheme.headline3,
          ),
          SizedBox(height: 10.h),
          Text(
            'Язык',
            style: _textTheme.subtitle2,
          ),
          SizedBox(height: 10.h),
          Text(
            'ФИО препода',
            style: _textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
