import 'package:elevate_tracking_app/core/custom_widget/custom_dialog.dart';

import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_vehicle_info_body_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../../../domain/entites/driver_entity.dart';

class EditVehicleInfoBody extends StatefulWidget {
  const EditVehicleInfoBody({super.key, required this.driverEntity});
  final DriverEntity driverEntity;

  @override
  State<EditVehicleInfoBody> createState() => _EditVehicleInfoBodyState();
}

class _EditVehicleInfoBodyState extends State<EditVehicleInfoBody> {
  @override
  void initState() {
    final cubit = BlocProvider.of<EditVehicleViewModel>(context);
    cubit.controllerVehicleNumber.text = widget.driverEntity.nid ?? "";
    cubit.controllerVehicleLicense.text = p.basename(
      widget.driverEntity.vehicleLicense!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocListener<EditVehicleViewModel, EditVehicleViewModelState>(
      listener: (context, state) {
        if (state.updateData?.isLoading == true) {
          CustomDialog.loading(context: context);
        } else if (state.updateData?.data != null) {
          context.pop();
          CustomDialog.positiveButton(
            context: context,
            title: local.successUpdatedData,
          );
        } else if (state.updateData?.errorMessage != null) {
          context.pop();
          CustomDialog.positiveButton(
            context: context,
            cancelable: true,
            title: state.updateData?.errorMessage,
          );
        }
      },
      child: const EditVehicleInfoViewBuilder(),
    );
  }
}
