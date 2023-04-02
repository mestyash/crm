import 'package:crm/core/domain/entity/user_model.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/search_users_modal_sheet/search_users_modal_sheet.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/payments/features/create_payment_screen/bloc/create_payment_bloc.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreatePaymentScreen extends StatelessWidget {
  final CreatePaymentBloc bloc;

  const CreatePaymentScreen({
    super.key,
    required this.bloc,
  });

  void _listener(BuildContext context, CreatePaymentState state) {
    final _l10n = context.l10n;
    if (state.isLoading) {
      context.loaderOverlay.show();
    }
    if (state.successfullyCreated) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
    }
    if (state.textFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
    if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(
          text: _l10n.dataError,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return BlocProvider<CreatePaymentBloc>(
      create: (_) => bloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: _l10n.mainAdminNavBarPayments,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ProjectMargin.contentHorizontal,
            vertical: ProjectMargin.contentTop,
          ),
          child: BlocConsumer<CreatePaymentBloc, CreatePaymentState>(
            listener: _listener,
            builder: (context, state) => _ScreenData(state: state),
          ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatefulWidget {
  final CreatePaymentState state;

  const _ScreenData({required this.state});

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late CreatePaymentBloc _bloc;
  late TextEditingController _studentController;
  late TextEditingController _dateController;

  @override
  void initState() {
    _bloc = context.read<CreatePaymentBloc>();
    _studentController = TextEditingController();
    _dateController = TextEditingController();
    super.initState();
  }

  void _onDateChange(DateTime date) {
    _dateController.text = CustomDateUtils.dateToString(date);
    _bloc.add(CreatePaymentEventDate(date: date));
  }

  void _onStudentChange(UserModel student) {
    _bloc.add(CreatePaymentEventStudent(student: student));
    _studentController.text = student.fullName;
  }

  void _onSearchStudents(String surname) {
    _bloc.add(CreatePaymentEventSearchStudents(surname: surname));
  }

  void _openModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<CreatePaymentBloc>.value(
        value: _bloc,
        child: BlocBuilder<CreatePaymentBloc, CreatePaymentState>(
          builder: (context, state) {
            return SearchUsersModalSheet(
              onTextChange: _onSearchStudents,
              isLoading: state.isSearching,
              users: state.students,
              onSelectUser: _onStudentChange,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _studentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        InputText(
          title: _l10n.apply,
          hintText: _l10n.studentPlaceholder,
          readOnly: true,
          controller: _studentController,
          onTap: _openModalSheet,
        ),
        InputText(
          title: _l10n.createPaymentSumPlaceholder,
          hintText: _l10n.sum,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          onChange: (sum) => _bloc.add(CreatePaymentEventSum(sum: sum)),
        ),
        InputDate(
          title: _l10n.createPaymentDatePlaceholder,
          hintText: _l10n.datePlaceholder,
          controller: _dateController,
          date: DateTime.now(),
          onChange: _onDateChange,
        ),
        CustomElevatedButton(
          text: _l10n.save.toUpperCase(),
          onTap: widget.state.canUpload
              ? () => _bloc.add(CreatePaymentEventUpload())
              : null,
        )
      ],
    );
  }
}
