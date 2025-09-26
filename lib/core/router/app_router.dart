import 'package:elevate_tracking_app/core/router/route_names.dart';
// import 'package:elevate_tracking_app/presentation/application_approved/views/screen/application_approved_screen.dart';
// import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.applicationApproved,
      builder: (context, state) => const ApplicationApprovedScreen(),
    ),
    GoRoute(
      path: RouteNames.mainHome,
      builder: (context, state) => MainHomeScreen(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: RouteNames.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RouteNames.apply,
      builder: (context, state) => const ApplyView(),
    ),
  ];

  static final router = GoRouter(
    initialLocation: RouteNames.apply,
    routes: routes,
  );
}
