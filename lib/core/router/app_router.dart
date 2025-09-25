import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/auth/forget_password/views/email_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/forget_password/views/forget_password_view.dart';
import '../../presentation/auth/forget_password/views/reset_password_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.forgetPassword,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: RouteNames.forgetPassword,
        builder: (context, state) =>  const ForgetPassword(),
      ),
      GoRoute(
        path: RouteNames.emailVerification,
        builder: (context, state) => const EmailVerification(),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) => const ResetPassword(),
      ),
    ],
  );
}
