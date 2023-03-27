import 'package:crm/core/presentation/ui/search_bar/staff_bar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUsersModalSheet extends StatelessWidget {
  const SearchUsersModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SearchBar(enabled: true, onTextChange: (text) {}),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: ProjectMargin.contentHorizontal,
                ),
                shrinkWrap: true,
                itemCount: 200,
                itemBuilder: (context, i) => _UserCard(),
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
  // final User user;

  // const _UserCard({required this.user});
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Text(
        '123',
        style: _textTheme.bodyText1,
      ),
    );
  }
}
