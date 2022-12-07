import 'package:crm/core/locator.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final _routes = sl<Map<String, WidgetBuilder>>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        theme: ProjectThemes.lightTheme,
        themeMode: ThemeMode.light,
        routes: _routes,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: Routes.login,
      ),
    );
  }
}
