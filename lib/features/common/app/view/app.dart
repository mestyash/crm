import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/app/view/widgets/overlay_loader.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  final CurrentUserCubit currentUserCubit;
  final Map<String, WidgetBuilder> router;

  App({
    super.key,
    required this.currentUserCubit,
    required this.router,
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
          overlayWidget: OverlayLoader(),
          child: MaterialApp(
            theme: ProjectThemes.lightTheme,
            themeMode: ThemeMode.light,
            routes: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: Routes.splash,
          ),
        ),
      ),
    );
  }
}
