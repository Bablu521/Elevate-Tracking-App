import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountCancelledCompletedOrdersSection extends StatelessWidget {
  final List<DriverOrderEntityDriverRelated> orderList;
  const CountCancelledCompletedOrdersSection({
    super.key,
    required this.orderList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(minHeight: 75.h),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    orderList
                        .where((e) => e.order?.state == "canceled")
                        .length
                        .toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage(AppIcons.iconCancelled),
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context).cancelled,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 33.w),
        Flexible(
          child: Container(
            constraints: BoxConstraints(minHeight: 75.h),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    orderList
                        .where((e) => e.order?.state == "completed")
                        .length
                        .toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage(AppIcons.iconCompleted),
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context).completed,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
