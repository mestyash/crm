import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/search_users_modal_sheet/search_users_modal_sheet.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/payments/features/create_payment_screen/cubit/create_payment_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePaymentScreen extends StatelessWidget {
  final CreatePaymentCubit cubit;

  const CreatePaymentScreen({
    super.key,
    required this.cubit,
  });

  void _listener(BuildContext context, CreatePaymentState state) {
    final _l10n = context.l10n;

    if (state.textFailure) {
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

    return BlocProvider<CreatePaymentCubit>(
      create: (_) => cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: _l10n.mainAdminNavBarPayments,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ProjectMargin.contentHorizontal,
            vertical: ProjectMargin.contentTop,
          ),
          child: BlocListener<CreatePaymentCubit, CreatePaymentState>(
            listener: _listener,
            child: _ScreenData(),
          ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatefulWidget {
  const _ScreenData();

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late CreatePaymentCubit _cubit;
  late TextEditingController _dateController;

  @override
  void initState() {
    _cubit = context.read<CreatePaymentCubit>();
    _dateController = TextEditingController()..text;
    super.initState();
  }

  void _onDateChange(DateTime date) {
    _dateController.text = CustomDateUtils.dateToString(date);
    _cubit.onDateChange(date);
  }

  void _openModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchUsersModalSheet(),
    );
  }

  @override
  void dispose() {
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
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onTap: _openModalSheet,
        ),
        InputText(
          title: _l10n.createPaymentSumPlaceholder,
          hintText: _l10n.sum,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          onChange: (sum) => _cubit.onSumChange(sum),
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
          onTap: () {},
        )
      ],
    );
  }
}
