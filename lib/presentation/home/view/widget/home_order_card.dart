import 'package:elevate_tracking_app/presentation/home/view/widget/home_info_card.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/home_events.dart';

class HomeOrderCard extends StatelessWidget {
  final int index;
  final OrderEntity orderEntity;
  final HomeViewModel homeViewModel;

  const HomeOrderCard({
    super.key,
    required this.index,
    required this.homeViewModel,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text(
            AppLocalizations.of(context).flowerOrder,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
          ),
          HomeInfoCard(
            title: AppLocalizations.of(context).pickupAddress,
            image: orderEntity.store?.image ?? "",
            name: orderEntity.store?.name ?? "",
            address: orderEntity.store?.address ?? "",
          ),
          HomeInfoCard(
            title: AppLocalizations.of(context).userAddress,
            image: orderEntity.user?.photo ?? "",
            name: orderEntity.user?.firstName ?? "",
            address:
                "${orderEntity.shippingAddress?.street ?? ""}, ${orderEntity.shippingAddress?.city ?? ""}",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                "${AppLocalizations.of(context).egp} ${orderEntity.totalPrice ?? ""}",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: homeViewModel.rejectOrderIndex,
                  builder: (context, value, child) {
                    return value == index
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style
                                ?.copyWith(
                                  backgroundColor: WidgetStateProperty.all(
                                    AppColors.white,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    AppColors.mainColor,
                                  ),
                                  side: WidgetStateProperty.all(
                                    BorderSide(
                                      color: AppColors.mainColor,
                                      width: 1.w,
                                    ),
                                  ),
                                ),
                            onPressed: () {
                              homeViewModel.doIntent(RejectOrderEvent(index));
                            },
                            child: Text(AppLocalizations.of(context).reject),
                          );
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: homeViewModel.acceptOrderIndex,
                  builder: (context, value, child) {
                    return value == index
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              homeViewModel.doIntent(AcceptOrderEvent(index));
                            },
                            child: Text(AppLocalizations.of(context).accept),
                          );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
