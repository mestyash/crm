import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/cubit/upload_staff_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UploadStaffScreenArguments {
  final int id;

  UploadStaffScreenArguments({required this.id});
}

class UploadStaffScreen extends StatelessWidget {
  final UploadStaffCubit cubit;

  const UploadStaffScreen({
    super.key,
    required this.cubit,
  });

  void _listener(
    BuildContext context,
    UploadStaffState state,
  ) {
    final _l10n = context.l10n;

    if (state.isUploading) {
      context.loaderOverlay.show();
    } else if (state.successfullyUploaded) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(text: _l10n.error));
    } else if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenArguments = ModalRoute.of(context)?.settings.arguments
        as UploadStaffScreenArguments?;
    final _l10n = context.l10n;

    return BlocProvider<UploadStaffCubit>(
      create: (_) => cubit..getStaffEmployeeData(_screenArguments?.id),
      child: BlocConsumer<UploadStaffCubit, UploadStaffState>(
        listener: _listener,
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(
            title: _l10n.mainAdminNavBarStaff,
          ),
          body: _UploadStaffScreenData(state: state),
        ),
      ),
    );
  }
}

class _UploadStaffScreenData extends StatefulWidget {
  final UploadStaffState state;

  const _UploadStaffScreenData({required UploadStaffState this.state});

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
  late TextEditingController _workplaceController;

  @override
  void initState() {
    _nameController = TextEditingController()..text = widget.state.name;
    _surnameController = TextEditingController()..text = widget.state.surname;
    _patronymicController = TextEditingController()
      ..text = widget.state.patronymic;
    _birthdayController = TextEditingController()
      ..text = CustomDateUtils.dateToString(widget.state.birthday);
    _loginController = TextEditingController()..text = widget.state.login;
    _passwordController = TextEditingController();
    _workplaceController = TextEditingController();
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
    _workplaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ProjectMargin.contentHorizontal,
        vertical: ProjectMargin.contentTop,
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
