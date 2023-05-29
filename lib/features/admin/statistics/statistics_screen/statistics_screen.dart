import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.mainAdminNavBarStatistics),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ProjectMargin.contentHorizontal,
          vertical: ProjectMargin.contentTop,
        ),
        child: Column(
          children: [
            _Card(
              link: Routes.salaryStatistics,
              text: l10n.salaries,
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String link;
  final String text;

  const _Card({
    required this.link,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, link),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: ProjectShadow.boxShadow1,
          color: theme.cardColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textTheme.bodyLarge?.copyWith(height: 0),
        ),
      ),
    );
  }
}
