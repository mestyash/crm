import 'package:crm/core/presentation/view/custom_checkbox/custom_checkbox.dart';
import 'package:crm/core/presentation/view/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/view/input_title/input_title.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ProjectMargin.contentHorizontal,
              vertical: ProjectMargin.contentTop,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _l10n.loginScreenGreeting.toUpperCase(),
                  style: _textTheme.headline1,
                ),
                SizedBox(height: 17.5.h),
                Text(_l10n.loginScreenMessage, style: _textTheme.bodyText1),
                SizedBox(height: 33.h),
                InputTitle(text: _l10n.login),
                TextFormField(
                  // controller: _loginController,
                  decoration: InputDecoration(
                    hintText: _l10n.loginScreenLoginPlaceholder,
                    errorText: _l10n.loginScreenInputError,
                  ),
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  // onChanged: _onLoginChanged,
                ),
                SizedBox(height: ProjectMargin.inputMargin),
                InputTitle(text: _l10n.pass),
                TextFormField(
                  // controller: _loginController,
                  decoration: InputDecoration(
                    hintText: _l10n.loginScreenPassPlaceholder,
                    errorText: _l10n.loginScreenInputError,
                  ),
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  // onChanged: _onLoginChanged,
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {},
                  child: IntrinsicWidth(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5.r),
                        CustomCheckbox(
                          isSelected: true,
                          action: () {},
                        ),
                        SizedBox(width: 10.r),
                        Text(
                          _l10n.loginScreenCheckbox,
                          style: _textTheme.bodyText1?.copyWith(
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
                SizedBox(height: 49.h),
                CustomElevatedButton(
                  text: _l10n.enter.toUpperCase(),
                  onTap: null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
