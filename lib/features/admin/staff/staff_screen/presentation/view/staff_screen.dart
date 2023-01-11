import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/view/widgets/card/staff_card.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_search_bar.dart';
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
    return BlocConsumer<StaffCubit, StaffState>(
      listener: _listener,
      builder: (context, state) => StaffScreenData(state: state),
    );
  }
}

class StaffScreenData extends StatelessWidget {
  final StaffState state;

  const StaffScreenData({
    super.key,
    required this.state,
  });

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
                      itemBuilder: (context, i) => StaffCard(
                        employee: state.filteredStaffData![i],
                      ),
                      itemCount: state.filteredStaffData!.length,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        action: () {},
      ),
    );
  }
}
