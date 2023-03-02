import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/presentation/ui/user_card/user_card.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_search_bar.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/view/upload_staff_screen.dart';
import 'package:crm/features/admin/students/features/students_screen/cubit/students_cubit.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  void _listener(
    BuildContext context,
    StudentsState state,
  ) {
    final _l10n = context.l10n;

    if (state.isDeleting) {
      context.loaderOverlay.show();
    } else if (state.successfullyDeleted) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar.success(text: _l10n.mainStaffScreenSuccessfullyDeleted),
        );
    } else if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
      listener: _listener,
      builder: (context, state) => _StudentsScreenData(state: state),
    );
  }
}

class _StudentsScreenData extends StatelessWidget {
  final StudentsState state;

  const _StudentsScreenData({
    super.key,
    required this.state,
  });

  Future<void> uploadEmployeeLink(BuildContext context) async {
    final data = await Navigator.pushNamed(context, Routes.uploadStaff);
    if (data != null) {
      context.read<StaffCubit>().loadStaffData();
    }
  }

  void _deleteDialog(BuildContext context, int id) {
    final _l10n = context.l10n;
  }

  Future<void> _editUserLink(BuildContext context, int id) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.uploadStaff,
      arguments: UploadStaffScreenArguments(id: id),
    );

    if (data != null) {
      context.read<StaffCubit>().loadStaffData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarStaff,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ProjectMargin.contentHorizontal,
          vertical: ProjectMargin.contentTop,
        ),
        child: Column(
          children: [
            StaffSearchBar(
              enabled: !state.isLoading,
              onTextChange: (text) =>
                  context.read<StaffCubit>().onTextChange(text),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: state.isScreenLoading
                  ? ListView.builder(
                      itemBuilder: (context, i) => ShimmerContainer(
                        width: double.infinity,
                        height: 35.h,
                        margin: EdgeInsets.only(bottom: 10.h),
                      ),
                      itemCount: 30,
                    )
                  : ListView.builder(
                      itemBuilder: (context, i) {
                        final student = state.filteredStudents![i];
                        final id = student.id;
                        return UserCard(
                          fullName: student.fullName,
                          editAction: () => _editUserLink(context, id),
                          deleteAction: () => _deleteDialog(context, id),
                        );
                      },
                      itemCount: state.filteredStudents!.length,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        action: () => uploadEmployeeLink(context),
      ),
    );
  }
}
