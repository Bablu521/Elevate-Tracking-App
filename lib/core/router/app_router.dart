import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      

      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
