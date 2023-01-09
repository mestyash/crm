import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onPageChanged;

  const MainNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _l10n = context.l10n;

    // styles
    final _phoneMarginBottom = MediaQuery.of(context).padding.bottom;
    final _marginTop = _phoneMarginBottom == 0 ? 17.5.h : 12.5.h;
    final _marginBot = _phoneMarginBottom == 0 ? 17.5.h : _phoneMarginBottom;
    final _scaffoldColor = _theme.scaffoldBackgroundColor;

    final _defaultIcon = Icons.home;
    return Container(
      padding: EdgeInsets.fromLTRB(
        ProjectMargin.contentHorizontal,
        _marginTop,
        ProjectMargin.contentHorizontal,
        _marginBot,
      ),
      color: _theme.bottomNavigationBarTheme.backgroundColor,
      child: GNav(
        rippleColor: Colors.transparent,
        hoverColor: Colors.transparent,
        gap: 7.w,
        activeColor: _theme.primaryColor,
        tabBorderRadius: 5.r,
        iconSize: 24,
        padding: EdgeInsets.fromLTRB(9.w, 9.h, 5.w, 9.h),
        duration: Duration(milliseconds: 300),
        tabBackgroundColor: _theme.primaryColor,
        color: _scaffoldColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.sm,
          height: 0,
          fontFamily: 'Montserrat',
          color: _scaffoldColor,
        ),
        tabs: [
          GButton(
            leading: Icon(
              Icons.person,
              color: _scaffoldColor,
              size: 20.r,
            ),
            icon: _defaultIcon,
            text: _l10n.mainAdminNavBarStaff,
            iconColor: _scaffoldColor,
          ),
        ],
        selectedIndex: selectedIndex,
        onTabChange: onPageChanged,
      ),
      // ),
    );
  }
}
