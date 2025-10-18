import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entites/order_firestore_entity.dart';
import '../../../../generated/l10n.dart';
import 'location_info_card.dart';

class LocationBottomSheet extends StatelessWidget {
  final OrderFirestoreEntity? orderFirestoreEntity;
  final bool isUser;

  const LocationBottomSheet({
    super.key,
    required this.orderFirestoreEntity,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      maxHeight: 250.h,
      headerBar: Container(
        color: AppColors.white,
        height: 40.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Divider(
            thickness: 4,
            radius: BorderRadius.circular(4.sp),
            indent: 155.w,
            endIndent: 155.w,
          ),
        ),
      ),
      body: Container(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),
          child: Column(
            spacing: 16.h,
            children: isUser
                ? infoCards(context)
                : infoCards(context).reversed.toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> infoCards(BuildContext context) {
    return [
      LocationInfoCard(
        title: AppLocalizations.of(context).userAddress,
        image: orderFirestoreEntity?.order?.user?.photo ?? "",
        name: orderFirestoreEntity?.order?.user?.firstName ?? "",
        address:
            "${orderFirestoreEntity?.order?.shippingAddress?.street ?? ""}, ${orderFirestoreEntity?.order?.shippingAddress?.city ?? ""}",
      ),
      LocationInfoCard(
        title: AppLocalizations.of(context).pickupAddress,
        image: orderFirestoreEntity?.order?.store?.image ?? "",
        name: orderFirestoreEntity?.order?.store?.name ?? "",
        address: orderFirestoreEntity?.order?.store?.address ?? "",
      ),
    ];
  }
}
