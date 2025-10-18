import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';

import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entites/driver_entity.dart';

class ProfileDetailsCard extends StatelessWidget {
  final DriverEntity driverEntity;
  const ProfileDetailsCard({super.key, required this.driverEntity});

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
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: driverEntity.photo != null ?
                  NetworkImage(driverEntity.photo.toString()): const AssetImage(AppImages.imagePhotoProfile)
                ),
              ),
            ),
            SizedBox(width: 13.w),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${driverEntity.firstName ?? AppLocalizations.of(context).firstName} ${driverEntity.lastName ?? AppLocalizations.of(context).lastName}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      driverEntity.email ?? AppLocalizations.of(context).email,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      driverEntity.phone ??
                          AppLocalizations.of(context).phoneNumber,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  context.push(RouteNames.editProfileInfo);
                },
                child: const Icon(
                  key: Key(WidgetsKeys.kProfileScreenForwardIconToEditProfileInfo),
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
