import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/address_info_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FlowerOrderCustomCard extends StatelessWidget {
  final DriverOrderEntityDriverRelated driverOrderEntityDriverRelated;
  const FlowerOrderCustomCard({
    super.key,
    required this.driverOrderEntityDriverRelated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: InkWell(
        onTap: () {
          context.push(RouteNames.myOrdersDetails,extra: driverOrderEntityDriverRelated);
        },
        child: Container(
          key: const Key(WidgetsKeys.kDriverOrdersFlowerOrderCustomCard),
          padding: const EdgeInsets.all(16),
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withValues(alpha: 0.25),
                offset: const Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).flowerOrder,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      driverOrderEntityDriverRelated.order!.state! ==
                              "completed"
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
                      driverOrderEntityDriverRelated.order!.state! ==
                              "completed"
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context).pickupAddress,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
              ),
              SizedBox(height: 8.h),
              AddressInfoCustomCard(
                height: 60,
                title: "${driverOrderEntityDriverRelated.store!.name}",
                address: "${driverOrderEntityDriverRelated.store!.address}",
                imgUrl: "${driverOrderEntityDriverRelated.store!.image}",
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context).userAddress,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
              ),
              SizedBox(height: 8.h),
              AddressInfoCustomCard(
                height: 60,
                title:
                    "${driverOrderEntityDriverRelated.order!.user!.firstName} ${driverOrderEntityDriverRelated.order!.user!.lastName}",
                address:
                    "${driverOrderEntityDriverRelated.order!.shippingAddress?.street ?? AppLocalizations.of(context).fakeStreet} ${driverOrderEntityDriverRelated.order!.shippingAddress?.city ?? AppLocalizations.of(context).fakeCity}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
