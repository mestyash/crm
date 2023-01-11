import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/presentation/ui/search_bar/staff_search_bar.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/staff_screen/view/widgets/staff_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UploadStaffArguments {
  final int id;

  UploadStaffArguments({required this.id});
}

class UploadStaffScreen extends StatelessWidget {
  const UploadStaffScreen({super.key});

  void _listener(
    BuildContext context,
    StaffState state,
  ) {
    final _l10n = context.l10n;

    if (state.isDeleting) {
      context.loaderOverlay.show();
    } else if (state.successfullyDeleted) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          AppSnackBar.success(text: _l10n.mainStaffScreenSuccessfullyDeleted),
        );
    } else if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenArguments =
        ModalRoute.of(context)?.settings.arguments as UploadStaffArguments?;

    return _UploadStaffScreenData();
  }
}

class _UploadStaffScreenData extends StatefulWidget {
  const _UploadStaffScreenData();

  @override
  State<_UploadStaffScreenData> createState() => __UploadStaffScreenDataState();
}

class __UploadStaffScreenDataState extends State<_UploadStaffScreenData> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _patronymicController;
  late TextEditingController _birthdayController;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _roleController;
  late TextEditingController _workplaceController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _birthdayController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    _workplaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
