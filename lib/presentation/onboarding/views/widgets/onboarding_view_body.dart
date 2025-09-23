import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Center(
            child: Container(
              height: 364.h,
              width: 349,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.imageOnboarding),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppLocalizations.of(context).welcomeToFloweryRiderApp,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: ElevatedButton(
              key: const Key(WidgetsKeys.kOnboardingScreenLoginButton),
              onPressed: () {
                context.push(RouteNames.login);
              },
              child: Text(AppLocalizations.of(context).login),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: ElevatedButton(
              key: const Key(WidgetsKeys.kOnboardingScreenApplyNowButton),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll(AppColors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: const BorderSide(color: AppColors.gray),
                  ),
                ),
              ),
              onPressed: () {
                context.push(RouteNames.apply);
              },
              child: Text(
                AppLocalizations.of(context).applyNow,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
