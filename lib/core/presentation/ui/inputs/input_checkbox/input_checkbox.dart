import 'package:crm/core/presentation/ui/custom_checkbox/custom_checkbox.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputCheckbox extends StatelessWidget {
  final void Function() action;
  final bool isSelected;
  final String text;

  const InputCheckbox({
    super.key,
    required this.action,
    required this.isSelected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: EdgeInsets.only(bottom: ProjectMargin.inputMargin),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5.r),
              CustomCheckbox(
                isSelected: isSelected,
                action: action,
              ),
              SizedBox(width: 10.r),
              Text(
                text,
                style: _textTheme.bodyLarge?.copyWith(
                  height: 0,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
