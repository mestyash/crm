import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_bar.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUsersModalSheet extends StatelessWidget {
  final void Function(String surname) onTextChange;
  final bool isLoading;
  final List<UserModel> users;
  final void Function(UserModel) onSelectUser;

  const SearchUsersModalSheet({
    super.key,
    required this.onTextChange,
    required this.isLoading,
    required this.users,
    required this.onSelectUser,
  });

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: _theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 34.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 25.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ProjectMargin.contentHorizontal,
              ),
              child: CustomSearchBar(
                enabled: true,
                onTextChange: onTextChange,
                placeholder: _l10n.enterSurname,
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: isLoading
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: ProjectMargin.contentHorizontal,
                      ),
                      itemBuilder: (_, i) => ShimmerContainer(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: double.infinity,
                        height: 75.h,
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: ProjectMargin.contentHorizontal,
                      ),
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, i) => _UserCard(
                        user: users[i],
                        action: () => onSelectUser(users[i]),
                      ),
                    ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;
  final void Function() action;

  const _UserCard({
    required this.user,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return GestureDetector(
      onTap: () {
        action();
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: ProjectShadow.boxShadow1,
        ),
        child: Text(
          user.fullName,
          style: _textTheme.bodyLarge,
        ),
      ),
    );
  }
}
