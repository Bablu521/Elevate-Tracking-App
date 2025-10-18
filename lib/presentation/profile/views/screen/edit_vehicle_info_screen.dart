
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_event.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_vehicle_info_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entites/driver_entity.dart';

class EditVehicleInfoScreen extends StatelessWidget {



  const EditVehicleInfoScreen({super.key, required this.driverEntity});
  final DriverEntity driverEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(WidgetsKeys.kEditVehicleScreenAppBar),
        title: Text(
          AppLocalizations.of(context).editProfile,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              key: Key(WidgetsKeys.kEditVehicleScreenNotificationIcon),
              Icons.notifications_none_rounded,
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          key: const Key(WidgetsKeys.kEditVehicleInfoScreenArrowBaskIcon),
          child: IconButton(
            onPressed: () => context.canPop() ? context.pop() : null,
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<EditVehicleViewModel>()
          ..doIntent(
            EditVehicleInitializeAllDataEvent(
              vehicleId: driverEntity.vehicleType ?? "",
            ),
          ),
        child: SafeArea(child: EditVehicleInfoBody(driverEntity: driverEntity)),
      ),
    );
  }
}
