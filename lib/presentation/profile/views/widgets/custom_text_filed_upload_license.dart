import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_event.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFiledUploadLicense extends StatelessWidget {
  const CustomTextFiledUploadLicense({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<EditVehicleViewModel>(context);
    return BlocBuilder<EditVehicleViewModel, EditVehicleViewModelState>(
      builder: (context, state) {
        return TextFormField(
          style: theme.textTheme.bodyMedium,
          validator: Validations.validateText,
          controller: cubit.controllerVehicleLicense,
          key: const Key(
            WidgetsKeys.kEditVehicleScreenUpdateVehicleLicenseFormField,
          ),
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: state.vehicleLicenseImagePath != null
                ? const Icon(Icons.task_alt, color: AppColors.green)
                : null,
            label: Text(local.vehicleLicense),
            hintText: local.uploadLicensePhoto,
            suffixIcon: GestureDetector(
              onTap: () {
                cubit.doIntent(EditVehiclePickImageEvent());
              },
              child: ImageIcon(
                key: const Key(WidgetsKeys.kEditVehicleScreenIconUpload),
                const AssetImage(AppIcons.iconUpload),
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
