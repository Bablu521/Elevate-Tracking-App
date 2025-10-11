import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/my_orders_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyOrdersDetailsScreen extends StatelessWidget {
  final DriverOrderEntityDriverRelated driverOrderEntityDriverRelated;
  const MyOrdersDetailsScreen({super.key,required this.driverOrderEntityDriverRelated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).orderDetails,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            onPressed: () => context.canPop() ? context.pop() : null,
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
      ),
      body: SafeArea(child: MyOrdersDetailsViewBody(driverOrderEntityDriverRelated: driverOrderEntityDriverRelated)),
    );
  }
}