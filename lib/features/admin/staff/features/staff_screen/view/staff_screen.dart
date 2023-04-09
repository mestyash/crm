import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_cupertino_dialog/custom_cupertino_dialog.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/presentation/ui/user_card/user_card.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_bar.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/view/upload_staff_screen.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  void _listener(
    BuildContext context,
    StaffState state,
  ) {
    final _l10n = context.l10n;

    if (state.isDeleting) {
      context.loaderOverlay.show();
    } else if (state.successfullyDeleted) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar.success(text: _l10n.staffScreenSuccessfullyDeleted),
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
    return BlocConsumer<StaffCubit, StaffState>(
      listener: _listener,
      builder: (context, state) => _StaffScreenData(state: state),
    );
  }
}

class _StaffScreenData extends StatelessWidget {
  final StaffState state;

  const _StaffScreenData({required this.state});

  Future<void> uploadEmployeeLink(BuildContext context) async {
    final data = await Navigator.pushNamed(context, Routes.uploadStaff);
    if (data != null) {
      context.read<StaffCubit>().loadStaffData();
    }
  }

  void _deleteDialog(BuildContext context, {required int id}) {
    final _l10n = context.l10n;
    CustomCupertinoDialog(
      context: context,
      title: _l10n.staffScreenDeleteTeacher,
      content: _l10n.staffScreenDeleteTeacherConfirm,
      firstActionText: _l10n.cancel,
      firstAction: () => Navigator.pop(context),
      secondActionText: _l10n.delete,
      secondAction: () {
        context.read<StaffCubit>().deleteStaffEmployee(id);
      },
    );
  }

  Future<void> _editUserLink(BuildContext context, {required int id}) async {
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
            SearchBar(
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
                        final employee = state.filteredStaffData![i];
                        final user = employee.userData;
                        final id = user.id;
                        return UserCard(
                          fullName: user.fullName,
                          editAction: () => _editUserLink(context, id: id),
                          deleteAction: () => _deleteDialog(context, id: id),
                        );
                      },
                      itemCount: state.filteredStaffData!.length,
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
