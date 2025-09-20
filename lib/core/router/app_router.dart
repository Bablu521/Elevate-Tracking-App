import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
      

      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
