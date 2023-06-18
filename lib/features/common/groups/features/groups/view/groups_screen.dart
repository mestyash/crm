import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/exit_button/exit_button.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_bar.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/groups/features/groups/cubit/groups_cubit.dart';
import 'package:crm/features/common/groups/features/groups/view/widgets/groups_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  void _listener(
    BuildContext context,
    GroupsState state,
  ) {
    final _l10n = context.l10n;
    if (state.isFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      listener: _listener,
      builder: (context, state) => _ScreenData(state: state),
    );
  }
}

class _ScreenData extends StatelessWidget {
  final GroupsState state;

  const _ScreenData({required this.state});

  Future<void> _link(BuildContext context) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.group,
    );
    if (data != null) {
      await context.read<GroupsCubit>().loadGroups();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    final cubit = context.read<GroupsCubit>();

    final isAdmin = context.select((CurrentUserCubit e) => e.state!.isAdmin);

    final _padding = EdgeInsets.symmetric(
      horizontal: ProjectMargin.contentHorizontal,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarGroups,
        actions: [if (!isAdmin) ExitButton()],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              ProjectMargin.contentHorizontal,
              ProjectMargin.contentTop,
              ProjectMargin.contentHorizontal,
              20.h,
            ),
            child: CustomSearchBar(
              enabled: true,
              onTextChange: (text) => cubit.onTextChange(text),
            ),
          ),
          Expanded(
            child: state.isScreenLoading
                ? ListView.builder(
                    padding: _padding,
                    itemBuilder: (context, i) => ShimmerContainer(
                      width: double.infinity,
                      height: 35.h,
                      margin: EdgeInsets.only(bottom: 10.h),
                    ),
                    itemCount: 30,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: _padding,
                    itemBuilder: (context, i) {
                      return GroupsCard(group: state.filteredGroups[i]);
                    },
                    itemCount: state.filteredGroups.length,
                  ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isAdmin,
        child: CustomFloatingActionButton(
          action: () => _link(context),
        ),
      ),
    );
  }
}
