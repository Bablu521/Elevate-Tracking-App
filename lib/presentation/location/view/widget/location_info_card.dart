import 'package:elevate_tracking_app/presentation/location/view_model/location_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/custom_widget/custom_cached_network_image.dart';
import '../../view_model/location_events.dart';

class LocationInfoCard extends StatelessWidget {
  final String title;
  final String image;
  final String name;
  final String address;
  final String phone;
  final LocationViewModel locationViewModel;

  const LocationInfoCard({
    super.key,
    required this.title,
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
    required this.locationViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
        ),
        Container(
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.w,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CustomCachedNetworkImage(
                  width: 44.w,
                  height: 44.w,
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      spacing: 4.w,
                      children: [
                        Image.asset(
                          AppIcons.iconLocation,
                          fit: BoxFit.cover,
                          height: 16.w,
                          width: 16.w,
                        ),
                        Expanded(
                          child: Text(
                            address,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4.w,
                children: [
                  GestureDetector(
                    child: Image.asset(AppIcons.iconCall),
                    onTap: () {
                      locationViewModel.doIntent(LunchCallLocationEvent(phone));
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(AppIcons.iconWhatsapp),
                    onTap: () {
                      locationViewModel.doIntent(
                        LunchWhatsAppLocationEvent(phone),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
