import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_model.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffCard extends StatelessWidget {
  final StaffModel staff;

  const StaffCard({
    super.key,
    required this.staff,
  });

  void _deleteDialog(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _l10n = context.l10n;

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          _l10n.mainStaffScreenDeleteTeacher,
          style: _textTheme.subtitle2?.copyWith(height: 0),
        ),
        content: Text(
          _l10n.mainStaffScreenDeleteTeacherConfirm,
          style: _textTheme.bodyText2?.copyWith(height: 0, fontSize: 11.sp),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _l10n.cancel,
              style: _textTheme.bodyText1?.copyWith(
                height: 0,
                color: _theme.primaryColor,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _l10n.delete,
              style: _textTheme.bodyText1?.copyWith(
                height: 0,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      // padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              staff.fullName,
              style: _textTheme.subtitle2?.copyWith(height: 0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            child: Icon(
              Icons.edit,
              size: 20.r,
              color: _theme.primaryColor,
            ),
          ),
          SizedBox(width: 15.w),
          GestureDetector(
            onTap: () => _deleteDialog(context),
            child: Icon(
              Icons.delete,
              size: 20.r,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
