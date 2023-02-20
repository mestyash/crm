import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTitle extends StatelessWidget {
  final String text;
  final bool isRequired;

  const InputTitle({
    Key? key,
    required this.text,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(left: 13.w, bottom: 4.h),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: _textTheme.subtitle2?.copyWith(height: 0),
            ),
            if (isRequired)
              TextSpan(
                text: '*',
                style: TextStyle(
                  height: 0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
