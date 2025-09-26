import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/apply/view/screen/apply_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final List<GoRoute> routes = [
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
