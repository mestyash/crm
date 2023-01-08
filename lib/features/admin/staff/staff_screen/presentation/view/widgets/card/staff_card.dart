import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Text('123'),
    );
  }
}
