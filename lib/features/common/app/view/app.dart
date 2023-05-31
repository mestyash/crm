import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  final CurrentUserCubit currentUserCubit;
  final Map<String, WidgetBuilder> router;
  final GlobalKey<NavigatorState> navigator;

  App({
    super.key,
    required this.currentUserCubit,
    required this.router,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<CurrentUserCubit>(
            create: (_) => currentUserCubit,
          ),
        ],
        child: GlobalLoaderOverlay(
          closeOnBackButton: true,
          useDefaultLoading: false,
          overlayWidget: LoadingIndicator(),
          child: MaterialApp(
            navigatorKey: navigator,
            theme: ProjectThemes.lightTheme,
            themeMode: ThemeMode.light,
            routes: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: Routes.splash,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
