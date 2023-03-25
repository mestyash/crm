import 'package:crm/core/presentation/ui/custom_date_picker/custom_date_picker.dart';
import 'package:crm/core/presentation/ui/inputs/input_title/input_title.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputDate extends StatelessWidget {
  final bool isLoading;
  final String title;
  final DateTime date;
  final TextEditingController controller;
  final String hintText;
  final bool isRequired;
  final void Function(DateTime date) onChange;
  final CupertinoDatePickerMode mode;
  final DateTime? maximumDate;
  final bool showBottomMargin;

  const InputDate({
    super.key,
    this.isLoading = false,
    this.title = '',
    required this.date,
    required this.controller,
    this.hintText = '',
    this.isRequired = false,
    required this.onChange,
    this.mode = CupertinoDatePickerMode.date,
    this.maximumDate,
    this.showBottomMargin = true,
  });

  void openDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomDatePicker(
        initialDateTime: date,
        changeDate: onChange,
        datePickerMode: mode,
        maximumDate: maximumDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: showBottomMargin
          ? EdgeInsets.only(bottom: ProjectMargin.inputMargin)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) InputTitle(text: title, isRequired: isRequired),
          isLoading
              ? ShimmerContainer(width: double.infinity, height: 42.h)
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  maxLines: 1,
                  readOnly: true,
                  onTap: () => openDatePicker(context),
                ),
        ],
      ),
    );
  }
}
