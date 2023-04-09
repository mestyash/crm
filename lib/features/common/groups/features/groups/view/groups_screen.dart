import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_bar.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/groups/features/groups/view/widgets/groups_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _padding = EdgeInsets.symmetric(
      horizontal: ProjectMargin.contentHorizontal,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarGroups,
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
            child: SearchBar(enabled: true, onTextChange: (text) => {}),
          ),
          Expanded(
            child: false
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
                      return GroupsCard();
                    },
                    itemCount: 20,
                  ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        action: () => {},
      ),
    );
  }
}
