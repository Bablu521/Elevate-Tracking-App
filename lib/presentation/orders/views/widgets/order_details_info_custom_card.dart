import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsInfoCustomCard extends StatelessWidget {
  final String item;
  final String price;
  final int count;
  final String imgUrl;
  const OrderDetailsInfoCustomCard({
    required this.item,
    required this.price,
    required this.count,
    required this.imgUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        height: 76.h,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(fontSize: 13.sp, color: AppColors.gray),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "X$count",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13.sp,
                          fontFamily: ConstKeys.robotoFont,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "EGP $price",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13.sp,
                      fontFamily: ConstKeys.robotoFont,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
