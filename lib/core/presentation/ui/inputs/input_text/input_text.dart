import 'package:crm/core/presentation/ui/inputs/input_title/input_title.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputText extends StatelessWidget {
  final bool isLoading;
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isRequired;
  final int minLines;
  final int? maxLength;
  final bool readOnly;
  final void Function(String text)? onChange;
  final void Function()? onTap;

  const InputText({
    super.key,
    this.isLoading = false,
    this.controller,
    required this.title,
    this.hintText = '',
    this.isRequired = false,
    this.keyboardType,
    this.minLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: ProjectMargin.inputMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTitle(text: title, isRequired: isRequired),
          isLoading
              ? ShimmerContainer(width: double.infinity, height: 42.h)
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                  keyboardType: keyboardType,
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  minLines: minLines,
                  maxLines: minLines == 1 ? 1 : null,
                  onChanged: onChange,
                  readOnly: readOnly,
                  onTap: onTap,
                  maxLength: maxLength,
                ),
        ],
      ),
    );
  }
}
