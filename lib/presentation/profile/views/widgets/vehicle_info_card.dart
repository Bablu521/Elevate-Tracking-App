import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoCard extends StatelessWidget {
  final DriverEntity driverEntity;
  final VehicleEntity vehicleEntity;
  const VehicleInfoCard({super.key, required this.driverEntity,required this.vehicleEntity});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 108.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).vehicleInfo,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        vehicleEntity.type ?? AppLocalizations.of(context).vehicleType,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(fontSize: 13),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        driverEntity.vehicleNumber ??
                            AppLocalizations.of(context).vehicleNumber,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  context.push(RouteNames.editVehicleInfo,extra: driverEntity);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: AppColors.gray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
