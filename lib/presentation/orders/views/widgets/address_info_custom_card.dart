import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressInfoCustomCard extends StatelessWidget {
  final int height;
  final String title;
  final String address;
  final String imgUrl;
  const AddressInfoCustomCard({
    super.key,
    required this.height,
    required this.title,
    required this.address,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: height.h,
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
        children: [
          Image(image: AssetImage(imgUrl), height: 44, width: 44),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.gray,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    const Image(
                      image: AssetImage(AppIcons.iconLocation),
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13.sp,
                          fontFamily: ConstKeys.robotoFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
