import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/settings/language/language_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/groups/features/group/view/group_screen.dart';
import 'package:crm/features/common/groups/features/groups/cubit/groups_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsCard extends StatelessWidget {
  final GroupModel group;

  const GroupsCard({
    super.key,
    required this.group,
  });

  Future<void> _link(BuildContext context) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.group,
      arguments: GroupScreenScreenArguments(id: group.id),
    );
    if (data != null) {
      await context.read<GroupsCubit>().loadGroups();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return GestureDetector(
      onTap: () => _link(context),
      child: Container(
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
              group.name,
              style: _textTheme.headline3,
            ),
            SizedBox(height: 10.h),
            Text(
              LanguageSettings.translateLanguage(_l10n, group.language),
              style: _textTheme.subtitle2,
            ),
            SizedBox(height: 10.h),
            Text(
              group.teacher.fullName,
              style: _textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
