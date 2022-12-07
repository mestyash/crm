import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/login_screen/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initGetIt() {
  // ---------- ROUTER ----------
  sl.registerLazySingleton<Map<String, WidgetBuilder>>(
    () => ({
      // --- common ---
      Routes.splash: (context) => sl.get<LoginScreen>(),
    }),
  );
}
