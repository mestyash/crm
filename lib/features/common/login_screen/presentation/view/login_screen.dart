import 'package:crm/core/presentation/ui/custom_checkbox/custom_checkbox.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_title/input_title.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/login_screen/presentation/cubit/login_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatelessWidget {
  final LoginCubit cubit;

  const LoginScreen({
    super.key,
    required this.cubit,
  });

  void _listener(BuildContext context, LoginState state) {
    if (state.isLoading) {
      context.loaderOverlay.show();
    }
    if (state.successfullyLoggedIn) {
      context.loaderOverlay.hide();
      Navigator.pushNamedAndRemoveUntil(
        context,
        state.redirectRoute,
        (route) => false,
      );
    }
    if (state.isFailure) {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => cubit,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _listener,
        builder: (context, state) => _ScreenData(state: state),
      ),
    );
  }
}

class _ScreenData extends StatelessWidget {
  final LoginState state;

  const _ScreenData({required this.state});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _textTheme = Theme.of(context).textTheme;
    final _cubit = BlocProvider.of<LoginCubit>(context);

    final _errorText = state.isFailure ? _l10n.loginScreenInputError : null;

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
                  decoration: InputDecoration(
                    hintText: _l10n.loginPlaceholder,
                    errorText: _errorText,
                  ),
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  onChanged: (login) => _cubit.onLoginChanged(login),
                ),
                SizedBox(height: ProjectMargin.inputMargin),
                InputTitle(text: _l10n.pass),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: _l10n.passPlaceholder,
                    errorText: _errorText,
                  ),
                  style: _textTheme.bodyText1?.copyWith(
                    height: 1.42,
                  ),
                  onChanged: (pass) => _cubit.onPassChanged(pass),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () => _cubit.onCheckboxChanged(),
                  child: IntrinsicWidth(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5.r),
                        CustomCheckbox(
                          isSelected: state.saveUserCredentials,
                          action: () => _cubit.onCheckboxChanged(),
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
                  onTap: state.canSend
                      ? () {
                          _cubit.onButtonPress();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
