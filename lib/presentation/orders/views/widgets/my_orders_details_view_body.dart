import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/address_info_custom_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_payment_method_card.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/order_details_info_custom_total_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersDetailsViewBody extends StatelessWidget {
  const MyOrdersDetailsViewBody({super.key});

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
                    const Image(
                      image: AssetImage(AppIcons.iconCompleted),
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      AppLocalizations.of(context).completed,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
                Text(
                  "# 123456",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Text(
              AppLocalizations.of(context).pickupAddress,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.h),
            const AddressInfoCustomCard(
              height: 76,
              title: "Flowery store",
              address: "20th st, Sheikh Zayed, Giza",
              imgUrl: AppImages.imageFloweryLogo,
            ),
            SizedBox(height: 24.h),
            Text(
              AppLocalizations.of(context).userAddress,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.h),
            const AddressInfoCustomCard(
              height: 60,
              title: "Nour mohamed",
              address: "20th st, Sheikh Zayed, Giza",
              imgUrl: AppImages.imageUserPhoto,
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return const OrderDetailsInfoCustomCard(
                  item: "Red roses,15 Pink Rose Bouquet",
                  price: "600",
                  imgUrl: AppIcons.iconCard,
                  count: 1,
                );
              },
            ),
            SizedBox(height: 20.h),
            const OrderDetailsInfoCustomTotalCard(total: 3000),
            SizedBox(height: 24.h),
            const OrderDetailsInfoCustomPaymentMethodCard(paymentMethod: "Cash on delivery",),
            SizedBox(height: 32.h)
          ],
        ),
      ),
    );
  }
}
