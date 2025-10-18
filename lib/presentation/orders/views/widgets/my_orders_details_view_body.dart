import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/address_info_custom_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_payment_method_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_total_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersDetailsViewBody extends StatelessWidget {
  final DriverOrderEntityDriverRelated driverOrderEntityDriverRelated;
  const MyOrdersDetailsViewBody({
    super.key,
    required this.driverOrderEntityDriverRelated,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    driverOrderEntityDriverRelated.order!.state! == "completed"
                        ? const Image(
                            image: AssetImage(AppIcons.iconCompleted),
                            height: 24,
                            width: 24,
                          )
                        : driverOrderEntityDriverRelated.order!.state! ==
                              "canceled"
                        ? const Image(
                            image: AssetImage(AppIcons.iconCancelled),
                            height: 24,
                            width: 24,
                          )
                        : const Image(
                            image: AssetImage(AppIcons.iconLoading),
                            height: 18,
                            width: 18,
                          ),
                    SizedBox(width: 4.w),
                    driverOrderEntityDriverRelated.order!.state! == "completed"
                        ? Text(
                            AppLocalizations.of(context).completed,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.green,
                                ),
                          )
                        : driverOrderEntityDriverRelated.order!.state! ==
                              "canceled"
                        ? Text(
                            AppLocalizations.of(context).cancelled,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red,
                                ),
                          )
                        : Text(
                            AppLocalizations.of(context).inProgress,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray,
                                ),
                          ),
                  ],
                ),
                Text(
                  "# ${driverOrderEntityDriverRelated.order!.id}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Text(
              AppLocalizations.of(context).pickupAddress,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.h),
            AddressInfoCustomCard(
              height: 76,
              title: "${driverOrderEntityDriverRelated.store!.name}",
              address: "${driverOrderEntityDriverRelated.store!.address}",
              imgUrl: "${driverOrderEntityDriverRelated.store!.image}",
            ),
            SizedBox(height: 24.h),
            Text(
              AppLocalizations.of(context).userAddress,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.h),
            AddressInfoCustomCard(
              height: 76,
              title:
                  "${driverOrderEntityDriverRelated.order!.user!.firstName} ${driverOrderEntityDriverRelated.order!.user!.lastName}",
              address:
                  "${driverOrderEntityDriverRelated.order!.shippingAddress?.street ?? AppLocalizations.of(context).fakeStreet} ${driverOrderEntityDriverRelated.order!.shippingAddress?.city ?? AppLocalizations.of(context).fakeCity}",
            ),
            SizedBox(height: 24.h),
            Text(
              AppLocalizations.of(context).orderDetails,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 12.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  driverOrderEntityDriverRelated.order!.orderItems!.length,
              itemBuilder: (context, index) {
                return OrderDetailsInfoCustomCard(
                  item: AppLocalizations.of(context).redRoses15PinkRoseBouquet,
                  price:
                      (driverOrderEntityDriverRelated
                              .order!
                              .orderItems![index]
                              .price)!
                          .toInt()
                          .toString(),
                  imgUrl: AppIcons.iconCard,
                  count:
                      driverOrderEntityDriverRelated
                          .order!
                          .orderItems![index]
                          .quantity ??
                      1,
                );
              },
            ),
            SizedBox(height: 20.h),
            OrderDetailsInfoCustomTotalCard(
              total: (driverOrderEntityDriverRelated.order!.totalPrice)
                  ?.toInt(),
            ),
            SizedBox(height: 24.h),
            OrderDetailsInfoCustomPaymentMethodCard(
              paymentMethod:
                  driverOrderEntityDriverRelated.order!.paymentType ??
                  AppLocalizations.of(context).cash,
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
