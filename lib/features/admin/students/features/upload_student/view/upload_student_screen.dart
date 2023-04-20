import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/students/features/upload_student/cubit/upload_student_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UploadStudentScreenArguments {
  final int id;

  UploadStudentScreenArguments({required this.id});
}

class UploadStudentScreen extends StatelessWidget {
  final UploadStudentCubit cubit;

  const UploadStudentScreen({
    super.key,
    required this.cubit,
  });

  void _listener(
    BuildContext context,
    UploadStudentState state,
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
          text: _l10n.uploadStudentSuccessfullyCreated,
        ));
    }
    if (state.successfullyEdited) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.uploadStudentSuccessfullyEdited,
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
        as UploadStudentScreenArguments?;
    final _l10n = context.l10n;

    return BlocProvider<UploadStudentCubit>(
      create: (_) => cubit..getStudentData(_screenArguments?.id),
      child: BlocConsumer<UploadStudentCubit, UploadStudentState>(
        listener: _listener,
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(
            title: _l10n.mainAdminNavBarStudents,
          ),
          body: state.isLoading
              ? LoadingIndicator()
              : _UploadStudentScreenData(state: state),
        ),
      ),
    );
  }
}

class _UploadStudentScreenData extends StatefulWidget {
  final UploadStudentState state;

  const _UploadStudentScreenData({required UploadStudentState this.state});

  @override
  State<_UploadStudentScreenData> createState() =>
      __UploadStudentScreenDataState();
}

class __UploadStudentScreenDataState extends State<_UploadStudentScreenData> {
  late UploadStudentCubit _cubit;

  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _patronymicController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    final state = widget.state;
    _cubit = context.read<UploadStudentCubit>();
    _nameController = TextEditingController()..text = state.name;
    _surnameController = TextEditingController()..text = state.surname;
    _patronymicController = TextEditingController()..text = state.patronymic;
    _birthdayController = TextEditingController()
      ..text = state.birthday != null
          ? CustomDateUtils.dateToString(widget.state.birthday)
          : '';
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
              hintText: _l10n.enterName,
              controller: _nameController,
              onChange: (text) => _cubit.onNameChange(text),
            ),
            InputText(
              title: _l10n.surname,
              hintText: _l10n.enterSurname,
              controller: _surnameController,
              onChange: (text) => _cubit.onSurnameChange(text),
            ),
            InputText(
              title: _l10n.patronymic,
              hintText: _l10n.enterPatronymic,
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
