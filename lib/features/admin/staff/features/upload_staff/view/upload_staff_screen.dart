import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/inputs/input_select/input_select.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/settings/workplace_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
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
    }
    if (state.successfullyCreated) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.uploadStaffSuccessfullyCreated,
        ));
    }
    if (state.successfullyEdited) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.uploadStaffSuccessfullyEdited,
        ));
    }
    if (state.isFailure) {
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
          body: state.isLoading
              ? LoadingIndicator()
              : _UploadStaffScreenData(state: state),
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
  late UploadStaffCubit _cubit;

  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _patronymicController;
  late TextEditingController _birthdayController;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _workplaceController;

  @override
  void initState() {
    final state = widget.state;
    _cubit = context.read<UploadStaffCubit>();
    _nameController = TextEditingController()..text = state.name;
    _surnameController = TextEditingController()..text = state.surname;
    _patronymicController = TextEditingController()..text = state.patronymic;
    _birthdayController = TextEditingController()
      ..text = state.birthday != null
          ? CustomDateUtils.dateToString(widget.state.birthday)
          : '';
    _loginController = TextEditingController()..text = state.login;
    _passwordController = TextEditingController()..text = state.password;
    _workplaceController = TextEditingController()
      ..text = state.workplace.toString();
    super.initState();
  }

  void _onDateChange(DateTime date) {
    _birthdayController.text = CustomDateUtils.dateToString(date);
    _cubit.onBirthdayChange(date);
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
    final _l10n = context.l10n;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ProjectMargin.contentHorizontal,
          vertical: ProjectMargin.contentTop,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputText(
              title: _l10n.name,
              hintText: _l10n.uploadStaffNamePlaceholder,
              controller: _nameController,
              onChange: (text) => _cubit.onNameChange(text),
            ),
            InputText(
              title: _l10n.surname,
              hintText: _l10n.uploadStaffSurnamePlaceholder,
              controller: _surnameController,
              onChange: (text) => _cubit.onSurnameChange(text),
            ),
            InputText(
              title: _l10n.patronymic,
              hintText: _l10n.uploadStaffPatronymicPlaceholder,
              controller: _patronymicController,
              onChange: (text) => _cubit.onPatronymicChange(text),
            ),
            InputDate(
              title: _l10n.birthday,
              hintText: _l10n.datePlaceholder,
              date: widget.state.birthday ?? DateTime.now(),
              controller: _birthdayController,
              onChange: _onDateChange,
            ),
            InputText(
              title: _l10n.login,
              hintText: _l10n.loginPlaceholder,
              controller: _loginController,
              onChange: (text) => _cubit.onLoginChange(text),
            ),
            InputText(
              title: _l10n.pass,
              hintText: _l10n.passPlaceholder,
              controller: _passwordController,
              onChange: (text) => _cubit.onPasswordChange(text),
            ),
            InputSelect(
              title: _l10n.workplace,
              hintText: _l10n.uploadStaffWorkplacePlaceholder,
              selectedValue: widget.state.workplace,
              valueNames: WorkplaceSettings.places
                  .map((e) => WorkplaceSettings.translatePlace(_l10n, e))
                  .toList(),
              values: WorkplaceSettings.places,
              onChange: (place) => _cubit.onWorkplaceChange(place as int),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              text: _l10n.save.toUpperCase(),
              onTap: widget.state.canSend ? () => _cubit.onUpload() : null,
            ),
          ],
        ),
      ),
    );
  }
}
