import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleInfoCard extends StatelessWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 108.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vehicle info",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Bike",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "UP16DL0007",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: InkWell(
                      onTap: () {
                        // navigate to update profile info
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}