import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/payments/features/payments_screen/view/widgets/card/payments_card.dart';
import 'package:crm/features/admin/payments/features/payments_screen/view/widgets/filter/payments_filter.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarPayments,
      ),
      body: Column(
        children: [
          PaymentsFilter(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: ProjectMargin.contentHorizontal,
                // vertical: ProjectMargin.contentTop,
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, i) => PaymentsCard(),
            ),
          ),
        ],
      ),
    );
  }
}
