import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SizedBox(),
      ),
    ],
  );
}
