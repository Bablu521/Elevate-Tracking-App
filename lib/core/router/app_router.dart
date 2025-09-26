import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/apply/view/screen/apply_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.apply,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: RouteNames.apply,
        builder: (context, state) => const ApplyView(),
      ),
    ],
  );
}
