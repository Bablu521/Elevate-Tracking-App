import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/logout_dialog.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/profile_details_card.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 31.h),
          const ProfileDetailsCard(),
          SizedBox(height: 24.h),
          const VehicleInfoCard(),
          SizedBox(height: 24.h),
          Container(
            height: 38.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 16.h,
                      width: 16.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppIcons.iconLanguage),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      AppLocalizations.of(context).language,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context).english,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 11,
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 38.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 16.h,
                      width: 16.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppIcons.iconLogoutSmall),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      AppLocalizations.of(context).logout,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                  ],
                ),
                InkWell(
                   onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => LogoutDialog(
                        onLogout: () {
                          // your logout logic here
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppIcons.iconLogoutLarge),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
