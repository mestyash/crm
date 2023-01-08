import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/view/widgets/card/staff_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _timetableListener(
      BuildContext context,
      StaffState state,
    ) {
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(AppSnackBar.failure(
            text: '1',
          ));
      }
    }

    return Container();
  }
}

class StaffScreenData extends StatelessWidget {
  const StaffScreenData({super.key});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarStaff,
      ),
      body: Column(
        children: [
          StaffCard(),
          StaffCard(),
          StaffCard(),
          StaffCard(),
          StaffCard(),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        action: () {},
      ),
    );
  }
}
