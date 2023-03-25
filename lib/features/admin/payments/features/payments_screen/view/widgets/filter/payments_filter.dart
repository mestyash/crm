import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsFilter extends StatefulWidget {
  const PaymentsFilter({super.key});

  @override
  State<PaymentsFilter> createState() => PpaymentsFilterState();
}

class PpaymentsFilterState extends State<PaymentsFilter> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    _startDateController = TextEditingController();
    _startDateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _nowDate = CustomDateUtils.dateToString(DateTime.now());
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
                textController: _startDateController,
              ),
              SizedBox(width: 20.w),
              _DatePicker(
                title: 'До',
                textController: _startDateController,
              ),
              SizedBox(width: 20.w),
              Icon(Icons.person),
            ],
          ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final String title;
  final TextEditingController textController;

  const _DatePicker({
    required this.title,
    required this.textController,
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
          width: 88.w,
          child: InputDate(
            hintText: _nowDate,
            controller: textController,
            showBottomMargin: false,
            date: DateTime.now(),
            onChange: (date) => {},
          ),
        ),
      ],
    );
  }
}
