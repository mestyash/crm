import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  final String fullName;
  final void Function()? editAction;
  final void Function() deleteAction;

  const UserCard({
    super.key,
    required this.fullName,
    required this.editAction,
    required this.deleteAction,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return GestureDetector(
      onTap: editAction,
      child: Container(
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
                fullName,
                style: _textTheme.subtitle2?.copyWith(height: 0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 5.w),
            Visibility(
              visible: editAction != null,
              child: Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: GestureDetector(
                  child: Icon(
                    Icons.edit,
                    size: 20.r,
                    color: _theme.primaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: deleteAction,
              child: Icon(
                Icons.delete,
                size: 20.r,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
