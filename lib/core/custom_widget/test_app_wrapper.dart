import 'package:elevate_tracking_app/core/constants/app_theme.dart';
import 'package:elevate_tracking_app/core/router/app_router.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TestAppWrapper extends StatelessWidget {
  final Widget child;

  const TestAppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    final router = GoRouter(
      initialLocation: '/test',
      routes: [
        GoRoute(
          path: '/test',
          builder: (context, state) => child, 
        ),
        ...AppRouter.routes, 
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          locale: const Locale("en"),
          routerConfig: router,
        );
      },
    );
  }
}
