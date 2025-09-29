import 'package:elevate_tracking_app/presentation/onboarding/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OnboardingViewBody()),
    );
  }
}