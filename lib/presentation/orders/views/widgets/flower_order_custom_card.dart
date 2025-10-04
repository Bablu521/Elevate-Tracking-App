import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/address_info_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FlowerOrderCustomCard extends StatelessWidget {
  const FlowerOrderCustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: InkWell(
        onTap: () {
          context.push(RouteNames.myOrdersDetails);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 300.h,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).flowerOrder,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "# 123456",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context).pickupAddress,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
              ),
              SizedBox(height: 8.h),
              const AddressInfoCustomCard(
                height: 60,
                title: "Flowery store",
                address: "20th st, Sheikh Zayed, Giza",
                imgUrl: AppImages.imageFloweryLogo,
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context).userAddress,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
              ),
              SizedBox(height: 8.h),
              const AddressInfoCustomCard(
                height: 60,
                title: "Nour mohamed",
                address: "20th st, Sheikh Zayed, Giza",
                imgUrl: AppImages.imageUserPhoto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
