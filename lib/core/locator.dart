import 'package:crm/core/api/groups/groups_supabase.dart';
import 'package:crm/core/api/lessons/lessons_supabase.dart';
import 'package:crm/core/api/payments/payments_supabase.dart';
import 'package:crm/core/api/staff/staff_supabase.dart';
import 'package:crm/core/api/students/students_supabase.dart';
import 'package:crm/core/data/data_source/secure_storage/secure_storage.dart';
import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/data/repository/current_user_repository.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/admin/main_admin_screen/main_admin_screen.dart';
import 'package:crm/features/admin/payments/core/data/repository/payments_repository.dart';
import 'package:crm/features/admin/payments/features/create_payment_screen/bloc/create_payment_bloc.dart';
import 'package:crm/features/admin/payments/features/create_payment_screen/view/create_payment_screen.dart';
import 'package:crm/features/admin/payments/features/payments_screen/bloc/payments_bloc.dart';
import 'package:crm/features/admin/staff/core/data/staff_repository.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/cubit/upload_staff_cubit.dart';
import 'package:crm/features/admin/staff/features/upload_staff/view/upload_staff_screen.dart';
import 'package:crm/features/admin/statistics/salary_statistics/data/repository/salary_statistics_repository.dart';
import 'package:crm/features/admin/statistics/salary_statistics/presentation/cubit/salary_statistics_cubit.dart';
import 'package:crm/features/admin/statistics/salary_statistics/presentation/view/salary_statistics_screen.dart';
import 'package:crm/features/admin/students/core/data/students_repository.dart';
import 'package:crm/features/admin/students/features/students_screen/cubit/students_cubit.dart';
import 'package:crm/features/admin/students/features/upload_student/cubit/upload_student_cubit.dart';
import 'package:crm/features/admin/students/features/upload_student/view/upload_student_screen.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:crm/core/api/profile/profile_supabase.dart';
import 'package:crm/core/data/data_source/user_credentials_storage/user_credentials_storage.dart';
import 'package:crm/features/common/groups/core/data/groups_repository.dart';
import 'package:crm/features/common/groups/features/group/bloc/group_bloc.dart';
import 'package:crm/features/common/groups/features/group/view/group_screen.dart';
import 'package:crm/features/common/groups/features/groups/cubit/groups_cubit.dart';
import 'package:crm/features/common/lessons/core/data/lessons_repository.dart';
import 'package:crm/features/common/lessons/features/lesson/cubit/lesson_cubit.dart';
import 'package:crm/features/common/lessons/features/lesson/view/lesson_screen.dart';
import 'package:crm/features/common/lessons/features/lessons/cubit/lessons_cubit.dart';
import 'package:crm/features/common/lessons/features/lessons/view/lessons_screen.dart';
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
      navigator: sl.get<GlobalKey<NavigatorState>>(),
    ),
  );
  sl.registerLazySingleton<Map<String, WidgetBuilder>>(
    () => ({
      Routes.splash: (context) => sl.get<SplashScreen>(),
      Routes.login: (context) => sl.get<LoginScreen>(),
      Routes.mainTeacher: (context) => sl.get<MainTeacherScreen>(),
      Routes.group: (context) => sl.get<GroupScreen>(),
      Routes.lessons: (context) => sl.get<LessonsScreen>(),
      Routes.lesson: (context) => sl.get<LessonScreen>(),
      Routes.mainAdmin: (context) => sl.get<MainAdminScreen>(),
      Routes.uploadStaff: (context) => sl.get<UploadStaffScreen>(),
      Routes.uploadStudent: (context) => sl.get<UploadStudentScreen>(),
      Routes.createPayment: (context) => sl.get<CreatePaymentScreen>(),
      Routes.salaryStatistics: (context) => sl.get<SalaryStatisticsScreen>(),
    }),
  );
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
  sl.registerFactory<GroupScreen>(
    () => GroupScreen(
      bloc: sl.get<GroupBloc>(),
    ),
  );
  sl.registerFactory<LessonsScreen>(
    () => LessonsScreen(
      cubit: sl.get<LessonsCubit>(),
    ),
  );
  sl.registerFactory<LessonScreen>(
    () => LessonScreen(
      cubit: sl.get<LessonCubit>(),
    ),
  );
  sl.registerFactory<MainTeacherScreen>(
    () => MainTeacherScreen(
      groupsCubit: sl.get<GroupsCubit>(),
    ),
  );
  sl.registerFactory<MainAdminScreen>(
    () => MainAdminScreen(
      staffCubit: sl.get<StaffCubit>(),
      studentsCubit: sl.get<StudentsCubit>(),
      paymentsBloc: sl.get<PaymentsBloc>(),
      groupsCubit: sl.get<GroupsCubit>(),
    ),
  );
  sl.registerFactory<UploadStaffScreen>(
    () => UploadStaffScreen(
      cubit: sl.get<UploadStaffCubit>(),
    ),
  );
  sl.registerFactory<UploadStudentScreen>(
    () => UploadStudentScreen(
      cubit: sl.get<UploadStudentCubit>(),
    ),
  );
  sl.registerFactory<CreatePaymentScreen>(
    () => CreatePaymentScreen(
      bloc: sl.get<CreatePaymentBloc>(),
    ),
  );
  sl.registerFactory<SalaryStatisticsScreen>(
    () => SalaryStatisticsScreen(
      cubit: sl.get<SalaryStatisticsCubit>(),
    ),
  );
  sl.registerLazySingleton<CurrentUserCubit>(
    () => CurrentUserCubit(
      repository: sl.get<CurrentUserRepository>(),
    ),
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
  sl.registerFactory<GroupsCubit>(
    () => GroupsCubit(
      repository: sl.get<GroupsRepository>(),
      currentUserCubit: sl.get<CurrentUserCubit>(),
    ),
  );
  sl.registerFactory<GroupBloc>(
    () => GroupBloc(
      repository: sl.get<GroupsRepository>(),
    ),
  );
  sl.registerFactory<LessonsCubit>(
    () => LessonsCubit(
      repository: sl.get<LessonsRepository>(),
    ),
  );
  sl.registerFactory<LessonCubit>(
    () => LessonCubit(
      repository: sl.get<LessonsRepository>(),
    ),
  );
  sl.registerFactory<SalaryStatisticsCubit>(
    () => SalaryStatisticsCubit(
      repository: sl.get<SalaryStatisticsRepository>(),
    ),
  );
  sl.registerFactory<StaffCubit>(
    () => StaffCubit(
      repository: sl.get<StaffRepository>(),
    ),
  );
  sl.registerFactory<UploadStaffCubit>(
    () => UploadStaffCubit(
      repository: sl.get<StaffRepository>(),
    ),
  );
  sl.registerFactory<StudentsCubit>(
    () => StudentsCubit(
      repository: sl.get<StudentsRepository>(),
    ),
  );
  sl.registerFactory<UploadStudentCubit>(
    () => UploadStudentCubit(
      repository: sl.get<StudentsRepository>(),
    ),
  );
  sl.registerFactory<PaymentsBloc>(
    () => PaymentsBloc(
      repository: sl.get<PaymentsRepository>(),
    ),
  );
  sl.registerFactory<CreatePaymentBloc>(
    () => CreatePaymentBloc(
      repository: sl.get<PaymentsRepository>(),
    ),
  );
  sl.registerFactory<CurrentUserRepository>(
    () => CurrentUserRepository(
      storage: sl.get<UserCredentialsStorage>(),
      navigator: sl.get<GlobalKey<NavigatorState>>(),
    ),
  );
  sl.registerFactory<SplashRepository>(
    () => SplashRepository(
      supabase: sl.get<ProfileSupabase>(),
      storage: sl.get<UserCredentialsStorage>(),
    ),
  );
  sl.registerFactory<LoginRepository>(
    () => LoginRepository(supabase: sl.get<ProfileSupabase>()),
  );
  sl.registerFactory<StaffRepository>(
    () => StaffRepository(
      supabase: sl.get<StaffSupabase>(),
    ),
  );
  sl.registerFactory<StudentsRepository>(
    () => StudentsRepository(
      supabase: sl.get<StudentsSupabase>(),
    ),
  );
  sl.registerFactory<PaymentsRepository>(
    () => PaymentsRepository(
      studentsSupabase: sl.get<StudentsSupabase>(),
      paymentsSupabase: sl.get<PaymentsSupabase>(),
    ),
  );
  sl.registerFactory<GroupsRepository>(
    () => GroupsRepository(
      groupsSupabase: sl.get<GroupsSupabase>(),
      studentsSupabase: sl.get<StudentsSupabase>(),
      staffSupabase: sl.get<StaffSupabase>(),
    ),
  );
  sl.registerFactory<LessonsRepository>(
    () => LessonsRepository(
      lessonsSupabase: sl.get<LessonsSupabase>(),
      groupsSupabase: sl.get<GroupsSupabase>(),
    ),
  );
  sl.registerFactory<SalaryStatisticsRepository>(
    () => SalaryStatisticsRepository(
      supabase: sl.get<LessonsSupabase>(),
    ),
  );
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
  sl.registerFactory<StudentsSupabase>(
    () => StudentsSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<PaymentsSupabase>(
    () => PaymentsSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<GroupsSupabase>(
    () => GroupsSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<LessonsSupabase>(
    () => LessonsSupabase(
      client: sl.get<SupabaseClient>(),
    ),
  );
  sl.registerFactory<UserCredentialsStorage>(
    () => UserCredentialsStorage(
      storage: sl.get<SecureStorage>(),
    ),
  );
  sl.registerFactory<SecureStorage>(() => SecureStorage());
  sl.registerFactory<SupabaseClient>(() => SupabaseClient());
  sl.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
  );
}
