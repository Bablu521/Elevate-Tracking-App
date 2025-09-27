import 'package:elevate_tracking_app/core/router/route_names.dart';
// import 'package:elevate_tracking_app/presentation/application_approved/views/screen/application_approved_screen.dart';
// import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/forget_password/views/screen/forget_password_screen.dart';

abstract class AppRouter {

  static final List<GoRoute> routes = [
    // GoRoute(
    //   path: RouteNames.onboarding,
    //   builder: (context, state) => const OnboardingScreen(),
    // ),
    // GoRoute(
    //   path: RouteNames.applicationApproved,
    //   builder: (context, state) => const ApplicationApprovedScreen(),
    // ),
     GoRoute(
       path: RouteNames.forgetPassword,
       builder: (context, state) =>  const ForgetPasswordScreen(),
     ),
  ];

  static final router = GoRouter(
    initialLocation: RouteNames.forgetPassword,
    routes: routes,
  );
}
