import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsInfoCustomTotalCard extends StatelessWidget {
  final int? total;
  const OrderDetailsInfoCustomTotalCard({super.key,this.total = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              height: 51.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray.withValues(alpha: 0.25),
                    offset: const Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).total , style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontFamily: ConstKeys.robotoFont,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text(
                    "Egp $total",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontFamily: ConstKeys.robotoFont,
                      color: AppColors.gray
                    ),
                  )
                ],
              ),
            );
  }
}