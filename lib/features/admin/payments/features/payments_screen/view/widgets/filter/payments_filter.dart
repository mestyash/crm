import 'package:crm/core/domain/entity/user_model.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/search_users_modal_sheet/search_users_modal_sheet.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/payments/features/payments_screen/bloc/payments_bloc.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsFilter extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final PaymentsStateMode mode;
  final UserModel? student;

  const PaymentsFilter({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.mode,
    required this.student,
  });

  @override
  State<PaymentsFilter> createState() => PpaymentsFilterState();
}

class PpaymentsFilterState extends State<PaymentsFilter> {
  late PaymentsBloc _bloc;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _studentController;

  @override
  void initState() {
    _bloc = context.read<PaymentsBloc>();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _studentController = TextEditingController();
    super.initState();
  }

  void _onStartDateChange(DateTime date) {
    _startDateController.text = CustomDateUtils.dateToString(date);
    _bloc.add(PaymentsEventStartDate(date: date));
  }

  void _onEndDateChange(DateTime date) {
    _endDateController.text = CustomDateUtils.dateToString(date);
    _bloc.add(PaymentsEventEndDate(date: date));
  }

  void _onModeChange() {
    _bloc.add(PaymentsEventMode());
    _studentController.text = '';
  }

  void _onStudentChange(UserModel student) {
    _studentController.text = student.fullName;
    _bloc.add(PaymentsEventStudent(student: student));
  }

  void _openModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<PaymentsBloc>.value(
        value: _bloc,
        child: BlocBuilder<PaymentsBloc, PaymentsState>(
          builder: (context, state) {
            return SearchUsersModalSheet(
              onTextChange: (surname) => _bloc.add(PaymentsEventSearchStudents(
                surname: surname,
              )),
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
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ProjectMargin.contentHorizontal,
        ProjectMargin.contentTop,
        ProjectMargin.contentHorizontal,
        ProjectMargin.inputMargin,
      ),
      child: Column(
        children: [
          Row(
            children: [
              _DatePicker(
                title: 'От',
                date: widget.startDate,
                textController: _startDateController,
                onDateChange: _onStartDateChange,
              ),
              SizedBox(width: 20.w),
              _DatePicker(
                title: 'До',
                date: widget.endDate,
                textController: _endDateController,
                onDateChange: _onEndDateChange,
              ),
              SizedBox(width: 20.w),
              Visibility(
                visible: widget.mode == PaymentsStateMode.all,
                child: GestureDetector(
                  onTap: _onModeChange,
                  child: Icon(Icons.person),
                ),
              ),
            ],
          ),
          if (widget.mode == PaymentsStateMode.student)
            Row(
              children: [
                Expanded(
                  child: InputText(
                    title: '',
                    hintText: _l10n.selectStudent,
                    readOnly: true,
                    controller: _studentController,
                    onTap: _openModalSheet,
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: _onModeChange,
                  child: Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final String title;
  final DateTime? date;
  final TextEditingController textController;
  final void Function(DateTime date) onDateChange;

  const _DatePicker({
    required this.title,
    required this.date,
    required this.textController,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _nowDate = CustomDateUtils.dateToString(DateTime.now());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: _textTheme.bodyText1?.copyWith(height: 0),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 105.w,
          child: InputDate(
            hintText: _nowDate,
            controller: textController,
            showBottomMargin: false,
            date: date ?? DateTime.now(),
            onChange: onDateChange,
          ),
        ),
      ],
    );
  }
}
