import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountCancelledCompletedOrdersSection extends StatelessWidget {
  const CountCancelledCompletedOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("4", style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage(AppIcons.iconCancelled),
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        AppLocalizations.of(context).cancelled,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 33.w),
        Expanded(
          child: Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "100",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage(AppIcons.iconCompleted),
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        AppLocalizations.of(context).completed,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
