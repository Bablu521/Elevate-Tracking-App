import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardPriceInfoOrder extends StatelessWidget {
  const CustomCardPriceInfoOrder({
    super.key,
    required this.title,
    this.subTitle,
  });
  final String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      key: const Key(WidgetsKeys.kOrderDetailsScreenPriceInfoOrder),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          children: [
            Text(
              title ?? "",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: ConstKeys.robotoFont,
              ),
            ),
            const Spacer(),
            Text(
              subTitle ?? "",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.gray,
                fontFamily: ConstKeys.robotoFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
