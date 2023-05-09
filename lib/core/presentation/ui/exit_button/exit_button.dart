import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_cupertino_dialog/custom_cupertino_dialog.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  void _exitDialog(BuildContext context) {
    final _l10n = context.l10n;
    CustomCupertinoDialog(
      context: context,
      title: _l10n.logOut,
      content: _l10n.logOutConfirm,
      firstActionText: _l10n.cancel,
      firstAction: () => Navigator.pop(context),
      secondActionText: _l10n.logOut,
      secondAction: () {
        context.read<CurrentUserCubit>().logOut();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _exitDialog(context),
      child: Icon(
        Icons.exit_to_app,
        size: 20.r,
      ),
    );
  }
}
