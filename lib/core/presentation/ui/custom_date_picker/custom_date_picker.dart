import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDateTime;
  final void Function(DateTime date) changeDate;
  final CupertinoDatePickerMode datePickerMode;

  const CustomDatePicker({
    Key? key,
    required this.initialDateTime,
    required this.changeDate,
    this.datePickerMode = CupertinoDatePickerMode.date,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _tempPickedDate;
  late CupertinoDatePickerMode _datePickerMode;

  @override
  void initState() {
    _tempPickedDate = widget.initialDateTime;
    _datePickerMode = widget.datePickerMode;

    super.initState();
  }

  void _changeTempPickedDate(DateTime data) {
    setState(() {
      _tempPickedDate = data;
    });
  }

  void _confirmTempPickedDate() {
    widget.changeDate(_tempPickedDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _theme = Theme.of(context);
    final _hasPadding = MediaQuery.of(context).padding.bottom == 0;
    final _containerHeight = _hasPadding ? 305.h : 295.h;
    final _buttonMargin = _hasPadding ? 10.h : 0.0;

    return Container(
      height: _containerHeight,
      padding:
          EdgeInsets.symmetric(horizontal: ProjectMargin.contentHorizontal),
      decoration: BoxDecoration(
        color: _theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 34.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      inherit: false,
                      fontFamily: 'Montserrat',
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w500,
                      color: _theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: _datePickerMode,
                  use24hFormat: true,
                  initialDateTime: widget.initialDateTime,
                  onDateTimeChanged: _changeTempPickedDate,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: _buttonMargin),
              child: CustomElevatedButton(
                text: _l10n.apply,
                onTap: _confirmTempPickedDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
