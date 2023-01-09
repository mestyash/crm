import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/core/data/data_source/secure_storage/secure_storage.dart';
import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/admin/main_admin_screen/main_admin_screen.dart';
import 'package:crm/features/admin/staff/staff_screen/data/repository/staff_repository.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/cubit/staff_cubit.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:crm/core/api/profile/profile_supabase.dart';
import 'package:crm/core/data/data_source/user_credentials_storage/user_credentials_storage.dart';
import 'package:crm/features/common/login_screen/data/login_repository.dart';
import 'package:crm/features/common/login_screen/presentation/cubit/login_cubit.dart';
import 'package:crm/features/common/login_screen/presentation/view/login_screen.dart';
import 'package:crm/features/common/splash_screen/data/splash_repository.dart';
import 'package:crm/features/common/splash_screen/presentation/cubit/splash_cubit.dart';
import 'package:crm/features/common/splash_screen/presentation/view/splash_screen.dart';
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
      Routes.splash: (context) => sl.get<SplashScreen>(),
      Routes.login: (context) => sl.get<LoginScreen>(),
      // --- teacher ---
      Routes.mainTeacher: (context) => sl.get<MainTeacherScreen>(),
      // --- admin ---
      Routes.mainAdmin: (context) => sl.get<MainAdminScreen>(),
    }),
  );
  // ---------- FEATURES ----------
  // --- COMMON ---
  sl.registerFactory<SplashScreen>(
    () => SplashScreen(
      cubit: sl.get<SplashCubit>(),
    ),
  );
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
    () => MainAdminScreen(
      staffCubit: sl.get<StaffCubit>(),
    ),
  );
  // ---------- BLOCS ----------
  // --- COMMON ---
  sl.registerLazySingleton<CurrentUserCubit>(
    () => CurrentUserCubit(),
  );
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(
      currentUserCubit: sl.get<CurrentUserCubit>(),
      repository: sl.get<SplashRepository>(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      currentUserCubit: sl.get<CurrentUserCubit>(),
      repository: sl.get<LoginRepository>(),
    ),
  );
  // --- ADMIN ---
  sl.registerFactory<StaffCubit>(
    () => StaffCubit(
      repository: sl.get<StaffRepository>(),
    ),
  );
  // ---------- REPOSITORIES ----------
  sl.registerFactory<SplashRepository>(
    () => SplashRepository(
      supabase: sl.get<ProfileSupabase>(),
      storage: sl.get<UserCredentialsStorage>(),
    ),
  );
  sl.registerFactory<LoginRepository>(
    () => LoginRepository(
      supabase: sl.get<ProfileSupabase>(),
      storage: sl.get<UserCredentialsStorage>(),
    ),
  );
  sl.registerFactory<StaffRepository>(
    () => StaffRepository(
      supabase: sl.get<StaffSupabase>(),
    ),
  );
  // ---------- DATA SOURCES ----------
  // API
  sl.registerFactory<ProfileSupabase>(
    () => ProfileSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<StaffSupabase>(
    () => StaffSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  // ---
  sl.registerFactory<UserCredentialsStorage>(
    () => UserCredentialsStorage(
      storage: sl.get<SecureStorage>(),
    ),
  );
  sl.registerFactory<SecureStorage>(() => SecureStorage());
  sl.registerFactory<SupabaseClient>(() => SupabaseClient());
}
