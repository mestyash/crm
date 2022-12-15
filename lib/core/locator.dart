import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:crm/features/common/login_screen/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initGetIt() {
  sl.registerLazySingleton(
    () => App(
      router: sl.get<Map<String, WidgetBuilder>>(),
    ),
  );
  // ---------- ROUTER ----------
  sl.registerLazySingleton<Map<String, WidgetBuilder>>(
    () => ({
      // --- common ---
      Routes.login: (context) => sl.get<LoginScreen>(),
    }),
  );
  // ---------- FEATURES ----------
  // --- COMMON ---
  sl.registerFactory<LoginScreen>(
    () => LoginScreen(),
  );
  // ---------- DATA SOURCES ----------
  sl.registerFactory<SupabaseClient>(() => SupabaseClient());
}
