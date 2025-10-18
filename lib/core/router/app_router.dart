import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/presentation/application_approved/views/screen/application_approved_screen.dart';
import 'package:elevate_tracking_app/presentation/auth/apply/view/screen/apply_view.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:elevate_tracking_app/presentation/main_home/views/screen/main_home_screen.dart';
import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/my_orders_details_screen.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/orders_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_profile_info_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_vehicle_info_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entites/driver_entity.dart';
import '../../presentation/auth/change_password/view/change_password_view.dart';
import '../../presentation/auth/forget_password/views/screen/forget_password_screen.dart';
import '../../presentation/location/view/screen/location_screen.dart';
import '../../presentation/order_details/view/screen/order_details_view.dart';
import '../models/track_screen_model.dart';

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
      path: RouteNames.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: RouteNames.profile,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: RouteNames.apply,
      builder: (context, state) => const ApplyView(),
    ),
    GoRoute(
      path: RouteNames.forgetPassword,
      builder: (context, state) =>  const ForgetPasswordScreen(),
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
    GoRoute(
      path: RouteNames.changePassword,
      builder: (context, state) => const ChangePassword(),
    ),
    GoRoute(
      path: RouteNames.myOrdersDetails,
      builder: (context, state) {
        final DriverOrderEntityDriverRelated driverOrderEntityDriverRelated = state.extra as DriverOrderEntityDriverRelated;
        return MyOrdersDetailsScreen(driverOrderEntityDriverRelated: driverOrderEntityDriverRelated);
      },
    ),
    GoRoute(
      path: RouteNames.locationScreen,
      builder: (context, state) {
        final TrackScreenModel trackScreenModel = state.extra as TrackScreenModel;
        return LocationScreen(trackScreenModel: trackScreenModel);
      },
    ),
    GoRoute(
      path: RouteNames.orderDetails,
      builder: (context, state) {
        final String orderId = state.extra as String;
        return OrderDetailsView(orderId: orderId);
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
