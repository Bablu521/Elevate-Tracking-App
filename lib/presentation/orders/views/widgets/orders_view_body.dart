import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/count_cancelled_completed_orders_section.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/flower_order_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            const CountCancelledCompletedOrdersSection(),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(context).recentOrders,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const FlowerOrderCustomCard();
              },
            ),
            SizedBox(height: 32.h,)
          ],
        ),
      ),
    );
  }
}
