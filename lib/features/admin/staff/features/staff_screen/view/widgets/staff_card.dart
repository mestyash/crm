import 'package:crm/core/presentation/ui/custom_cupertino_dialog/custom_cupertino_dialog.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/staff/core/domain/entity/staff_employee_model.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/view/upload_staff_screen.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffCard extends StatelessWidget {
  final StaffEmployeeModel employee;

  const StaffCard({
    super.key,
    required this.employee,
  });

  void _deleteDialog(BuildContext context) {
    final _l10n = context.l10n;
    CustomCupertinoDialog(
      context: context,
      title: _l10n.mainStaffScreenDeleteTeacher,
      content: _l10n.mainStaffScreenDeleteTeacherConfirm,
      firstActionText: _l10n.cancel,
      firstAction: () => Navigator.pop(context),
      secondActionText: _l10n.delete,
      secondAction: () {
        Navigator.pop(context);
        context.read<StaffCubit>().deleteStaffEmployee(employee.userData.id);
      },
    );
  }

  Future<void> _editUserLink(BuildContext context) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.uploadStaff,
      arguments: UploadStaffScreenArguments(id: employee.userData.id),
    );

    if (data != null) {
      context.read<StaffCubit>().loadStaffData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return GestureDetector(
      onTap: () => _editUserLink(context),
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
                employee.userData.fullName,
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
      ),
    );
  }
}
