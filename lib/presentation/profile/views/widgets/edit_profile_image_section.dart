import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileImageSection extends StatelessWidget {
  const EditProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 79.h,
            width: 74.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AppImages.imagePhotoEditProfile),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: (){
                // upload profile image
              },
              child: Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  color: AppColors.lightPink,
                  image: const DecorationImage(
                    image: AssetImage(AppIcons.iconCameraEditProfile),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
