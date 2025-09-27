import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    /*GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.applicationApproved,
      builder: (context, state) => const ApplicationApprovedScreen(),
    ),*/
  ];

  static GoRouter router(String? token) {
    return GoRouter(
      initialLocation: token == null ? RouteNames.login : RouteNames.home,
      routes: routes,
    );
  }
}
