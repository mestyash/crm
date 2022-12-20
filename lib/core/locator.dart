import 'package:crm/core/data/data_source/secure_storage/secure_storage.dart';
import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/admin/main_admin_screen/main_admin_screen.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:crm/features/common/login_screen/data/data_source/login_supabase.dart';
import 'package:crm/features/common/login_screen/data/data_source/user_credentials_storage.dart';
import 'package:crm/features/common/login_screen/data/repository/login_repository.dart';
import 'package:crm/features/common/login_screen/presentation/cubit/login_cubit.dart';
import 'package:crm/features/common/login_screen/presentation/view/login_screen.dart';
import 'package:crm/features/teacher/main_teacher_screen/main_teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initGetIt() {
  sl.registerLazySingleton(
    () => App(
      currentUserCubit: sl.get<CurrentUserCubit>(),
      router: sl.get<Map<String, WidgetBuilder>>(),
    ),
  );
  // ---------- ROUTER ----------
  sl.registerLazySingleton<Map<String, WidgetBuilder>>(
    () => ({
      // --- common ---
      Routes.login: (context) => sl.get<LoginScreen>(),
      // --- teacher ---
      Routes.mainTeacher: (context) => sl.get<MainTeacherScreen>(),
      // --- admin ---
      Routes.mainAdmin: (context) => sl.get<MainAdminScreen>(),
    }),
  );
  // ---------- FEATURES ----------
  // --- COMMON ---
  sl.registerFactory<LoginScreen>(
    () => LoginScreen(
      cubit: sl.get<LoginCubit>(),
    ),
  );
  // --- TEACHER ---
  sl.registerFactory<MainTeacherScreen>(
    () => MainTeacherScreen(),
  );
  // --- ADMIN ---
  sl.registerFactory<MainAdminScreen>(
    () => MainAdminScreen(),
  );
  // ---------- BLOCS ----------
  // --- COMMON ---
  sl.registerFactory<CurrentUserCubit>(
    () => CurrentUserCubit(),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      currentUserCubit: sl.get<CurrentUserCubit>(),
      repository: sl.get<LoginRepository>(),
    ),
  );
  // ---------- REPOSITORIES ----------
  sl.registerFactory<LoginRepository>(
    () => LoginRepository(
      supabase: sl.get<LoginSupabase>(),
      storage: sl.get<LoginStorage>(),
    ),
  );
  // ---------- DATA SOURCES ----------
  sl.registerFactory<LoginSupabase>(
    () => LoginSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<LoginStorage>(
    () => LoginStorage(
      storage: sl.get<SecureStorage>(),
    ),
  );
  sl.registerFactory<SecureStorage>(() => SecureStorage());
  sl.registerFactory<SupabaseClient>(() => SupabaseClient());
}
