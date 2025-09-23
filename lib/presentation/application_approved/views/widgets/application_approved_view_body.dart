import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ApplicationApprovedViewBody extends StatelessWidget {
  const ApplicationApprovedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(AppImages.imageBg,fit: BoxFit.cover,
            width: double.infinity,
          )),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 124.h),
                  Container(
                    height: 115.h,
                    width: 115.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.imageApplySuccess),
                      ),
                    ),
                  ),
                  SizedBox(height: 47.h),
                  Text(
                    AppLocalizations.of(context).yourApplicationHasBeenSubmitted,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppLocalizations.of(context).thankYouForProvidingYourApplicationWeWillReviewYourApplicationAndWillGetBackToYouSoon,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: AppColors.gray),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key(WidgetsKeys.kApplicationApprovedScreenLoginButton),
                      onPressed: () {
                        context.push(RouteNames.login);
                      },
                      child: Text(AppLocalizations.of(context).login),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
       
    );
  }
}
