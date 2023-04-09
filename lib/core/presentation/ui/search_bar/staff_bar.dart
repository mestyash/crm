import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final bool enabled;
  final void Function(String text) onTextChange;
  final String placeholder;

  const SearchBar({
    Key? key,
    required this.enabled,
    required this.onTextChange,
    this.placeholder = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        height: 42.r,
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              child: TextField(
                enabled: enabled,
                decoration: InputDecoration(
                  hintText: placeholder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: _theme.canvasColor,
                ),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: _textTheme.bodyText1?.copyWith(
                  height: 1.42,
                ),
                onChanged: onTextChange,
              ),
            ),
            FittedBox(
              child: Container(
                width: 42.r,
                height: 42.r,
                color: _theme.primaryColor,
                alignment: Alignment.center,
                child: Icon(
                  Icons.search,
                  size: 25.r,
                  color: _theme.cardColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
