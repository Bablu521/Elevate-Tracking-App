import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/domain/entites/order_firestore_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/order_details/view/widgets/custom_card_order_details_info.dart';
import 'package:elevate_tracking_app/presentation/order_details/view/widgets/custom_card_price_info_order.dart';
import 'package:elevate_tracking_app/presentation/order_details/view/widgets/custom_order_status.dart';
import 'package:elevate_tracking_app/presentation/order_details/view/widgets/custom_user_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key, required this.orderFirestoreEntity});
  final OrderFirestoreEntity? orderFirestoreEntity;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SingleChildScrollView(
        key: const Key(WidgetsKeys.kOrderDetailsScreenScrolling),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              key: Key(WidgetsKeys.kOrderDetailsScreenLinearProgressIndicator),
              value: 2 / 4,
              trackGap: 8,
              year2023: false,
            ),
            SizedBox(height: 24.h),
            CustomOrderStatus(
              orderId: orderFirestoreEntity?.order?.id,
              status: orderFirestoreEntity?.order?.state,
              createdAt: orderFirestoreEntity?.order?.createdAt,
            ),
            SizedBox(height: 16.h),
            Text(
              key: const Key(WidgetsKeys.kOrderDetailsScreenPickupText),
              local.pickupAddress,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            CustomUserOrderInfoItem(
              address: orderFirestoreEntity?.order?.store?.address,
              imagePath: orderFirestoreEntity?.order?.store?.image,
              phoneNumber: orderFirestoreEntity?.order?.store?.phoneNumber,
              name: orderFirestoreEntity?.order?.store?.name,
            ),
            SizedBox(height: 24.h),
            Text(
              key: const Key(WidgetsKeys.kOrderDetailsScreenUserAddressText),
              local.userAddress,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            CustomUserOrderInfoItem(
              address: orderFirestoreEntity?.location?.address,
              imagePath: orderFirestoreEntity?.order?.user?.photo,
              phoneNumber: orderFirestoreEntity?.order?.user?.phone,
              name: orderFirestoreEntity?.order?.user?.firstName,
            ),
            SizedBox(height: 24.h),
            Text(
              key: const Key(WidgetsKeys.kOrderDetailsScreenOrderDetailsText),
              local.orderDetails,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            ListView.separated(
              itemBuilder: (context, index) {
                final selectedOrder =
                    orderFirestoreEntity?.order?.orderItems?[index];
                return CustomCardOrderDetailsInfo(
                  amount: selectedOrder?.quantity.toString(),
                  imagePath: selectedOrder?.product?.imgCover,
                  orderName: selectedOrder?.product?.title,
                  orderPrice: selectedOrder?.product?.price.toString(),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
              itemCount: orderFirestoreEntity?.order?.orderItems?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),

            SizedBox(height: 24.h),
            CustomCardPriceInfoOrder(
              title: local.total,
              subTitle:
                  "${local.egp} ${orderFirestoreEntity?.order?.totalPrice.toString()}",
            ),
            SizedBox(height: 24.h),
            CustomCardPriceInfoOrder(
              title: local.paymentMethod,
              subTitle: orderFirestoreEntity?.order?.paymentType,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 48.h,
              width: double.infinity,
              child: ElevatedButton(
                key: const Key(WidgetsKeys.kOrderDetailsScreenMainButton),
                onPressed: () {},
                child: Text(
                  local.arrivedAtPickupPoint,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
