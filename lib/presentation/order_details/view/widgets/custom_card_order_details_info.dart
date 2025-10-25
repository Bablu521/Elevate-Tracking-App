import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/custom_cached_network_image.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';

class CustomCardOrderDetailsInfo extends StatelessWidget {
  const CustomCardOrderDetailsInfo({
    super.key,
    this.imagePath,
    this.orderName,
    this.orderPrice,
    this.amount,
  });

  final String? imagePath, orderName, orderPrice, amount;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      key: const Key(WidgetsKeys.kOrderDetailsScreenOrderDetailsInfoCard),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),

      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (imagePath != null &&
                    imagePath!.isNotEmpty &&
                    imagePath!.startsWith('http'))
                ? ClipOval(
                    key: const Key(
                      WidgetsKeys.kOrderDetailsScreenOrderDetailsCardImage,
                    ),
                    child: CustomCachedNetworkImage(
                      imageUrl: imagePath,
                      height: 44.h,
                      width: 44.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(AppImages.imageFloweryLogo),
                  ),
            SizedBox(width: 8.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Text(
                    orderName ?? "",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gray,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${local.egp} $orderPrice",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      fontFamily: ConstKeys.robotoFont,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              "${amount ?? 0}X",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
                fontSize: 13.sp,
                fontFamily: ConstKeys.robotoFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
