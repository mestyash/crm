import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/settings/language/language_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/groups/features/group/view/group_screen.dart';
import 'package:crm/features/common/groups/features/groups/cubit/groups_cubit.dart';
import 'package:crm/features/common/lessons/features/lessons/view/lessons_screen.dart';
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

  void _modalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ModalSheet(
        link1: () {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            Routes.lessons,
            arguments: LessonsScreenArguments(
              id: group.id,
              groupName: group.name,
            ),
          );
        },
        link2: () {
          Navigator.pop(context);
          _info(context);
        },
      ),
    );
  }

  Future<void> _info(BuildContext context) async {
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

    final isAdmin = context.select((CurrentUserCubit e) => e.state!.isAdmin);

    return GestureDetector(
      onTap: () => _modalSheet(context),
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
            Visibility(
              visible: isAdmin,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  group.teacher.fullName,
                  style: _textTheme.subtitle2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalSheet extends StatelessWidget {
  final void Function() link1;
  final void Function() link2;

  const _ModalSheet({
    required this.link1,
    required this.link2,
  });

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      color: Colors.white,
      child: SafeArea(
        child: IntrinsicHeight(
          child: Column(
            children: [
              _ModalSheetItem(action: link1, text: _l10n.statements),
              SizedBox(height: 10.h),
              Divider(height: 0),
              SizedBox(height: 7.5.h),
              _ModalSheetItem(action: link2, text: _l10n.info),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalSheetItem extends StatelessWidget {
  final String text;
  final void Function() action;

  const _ModalSheetItem({
    required this.text,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: action,
      child: Text(
        text,
        style: _textTheme.bodyText1,
      ),
    );
  }
}
