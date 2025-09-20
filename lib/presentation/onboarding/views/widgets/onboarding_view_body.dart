import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 364.h,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.imageOnboarding))
            ),
          )
        ],
      ),
    );
  }
}