import 'package:crm/core/presentation/ui/inputs/input_title/input_title.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputSelect<T> extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String hintText;
  final bool isRequired;
  final dynamic selectedValue;
  final List<String> valueNames;
  final List<T> values;
  final bool readOnly;
  final void Function(dynamic value) onChange;

  const InputSelect({
    super.key,
    this.isLoading = false,
    required this.title,
    this.hintText = '',
    this.isRequired = false,
    required this.selectedValue,
    required this.valueNames,
    required this.values,
    this.readOnly = false,
    required this.onChange,
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
              : DropdownButtonFormField<dynamic>(
                  value: selectedValue,
                  decoration: InputDecoration(hintText: hintText),
                  isExpanded: true,
                  items: [
                    for (int i = 0; i < valueNames.length; i++)
                      DropdownMenuItem<dynamic>(
                        value: values[i],
                        child: Text(
                          valueNames[i],
                          style: _textTheme.bodyLarge,
                        ),
                      ),
                  ],
                  onChanged: readOnly ? null : onChange,
                ),
        ],
      ),
    );
  }
}
