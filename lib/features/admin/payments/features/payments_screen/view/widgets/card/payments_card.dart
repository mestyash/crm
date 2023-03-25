import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsCard extends StatelessWidget {
  const PaymentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
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
            'Voytenko A.M.',
            style: _textTheme.headline3,
          ),
          SizedBox(height: 10.h),
          Text(
            '500 ₽',
            style: _textTheme.subtitle2,
          ),
          SizedBox(height: 10.h),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Дата:  ',
                  style: _textTheme.bodyText1
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: '27.02.2001',
                  style: _textTheme.bodyText1?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
