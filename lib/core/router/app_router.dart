import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/presentation/application_approved/views/screen/application_approved_screen.dart';
import 'package:elevate_tracking_app/presentation/home/views/screen/home_screen.dart';
import 'package:elevate_tracking_app/presentation/main_home/views/screen/main_home_screen.dart';
import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/orders_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_profile_info_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_vehicle_info_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
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
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: RouteNames.editProfileInfo,
      builder: (context, state) => const EditProfileInfoScreen(),
    ),
    GoRoute(
      path: RouteNames.editVehicleInfo,
      builder: (context, state) {
        final DriverEntity driverEntity = state.extra as DriverEntity;
        return EditVehicleInfoScreen(driverEntity: driverEntity);
      },
    ),
  ];

  static GoRouter router(String? token) {
    return GoRouter(
      initialLocation: token == null
          ? RouteNames.onboarding
          : RouteNames.mainHome,
      routes: routes,
    );
  }
}
