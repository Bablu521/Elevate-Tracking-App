import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOrderProgressBar extends StatelessWidget {
  const CustomOrderProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });
  final int currentStep;
  final int totalSteps;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isCompleted = index - 1 < currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.green : AppColors.white[70],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
