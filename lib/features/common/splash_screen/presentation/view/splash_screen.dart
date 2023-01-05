import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/splash_screen/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit cubit;

  const SplashScreen({
    super.key,
    required this.cubit,
  });

  void _listener(BuildContext context, SplashState state) {
    if (state.isAuthenticated == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        state.redirectRoute,
        (route) => false,
      );
    }
    if (state.isUnauthenticated == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => cubit..onLogin(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: _listener,
        child: Container(),
      ),
    );
  }
}
