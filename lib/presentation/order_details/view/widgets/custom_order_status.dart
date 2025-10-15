import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomOrderStatus extends StatelessWidget {
  const CustomOrderStatus({
    super.key,
    this.orderId,
    this.status,
    this.createdAt,
  });
  final String? orderId, status, createdAt;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return Container(
      key: const Key(WidgetsKeys.kOrderDetailsScreenOrderStatus),
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.lightPink,
      ),
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${local.status} : $status",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${local.orderId} : $orderId",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat(
              'EEEE, d MMM yyyy , hh:mm a',
            ).format(DateTime.parse(createdAt ?? "")),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
