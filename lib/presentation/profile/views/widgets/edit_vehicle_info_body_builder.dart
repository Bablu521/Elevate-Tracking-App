import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_event.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/custom_text_field_edit_vehicle.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/custom_text_filed_upload_license.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditVehicleInfoViewBuilder extends StatelessWidget {
  const EditVehicleInfoViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<EditVehicleViewModel>(context);
    return Form(
      key: cubit.globalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            const CustomTextFieldEditVehicle(),
            SizedBox(height: 24.h),
            TextFormField(
              controller: cubit.controllerVehicleNumber,
              validator: Validations.validateText,
              style: theme.textTheme.bodyMedium,
              key: const Key(
                WidgetsKeys.kEditVehicleScreenVehicleNumberFormField,
              ),
              decoration: InputDecoration(
                label: Text(local.vehicleNumber),
                hintText: local.enterVehicleNumber,
              ),
            ),
            SizedBox(height: 24.h),
            const CustomTextFiledUploadLicense(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder<bool>(
                valueListenable: cubit.isUserAuthenticated,
                builder: (context, value, child) {
                  return ElevatedButton(
                    key: const Key(
                      WidgetsKeys.kEditVehicleElevatedButtonUpdate,
                    ),
                    onPressed: value
                        ? () {
                            if (cubit.globalKey.currentState!.validate()) {
                              cubit.doIntent(EditVehiclePickUpdateDataEvent());
                            }
                          }
                        : null,
                    child: Text(
                      local.update,
                      key: const Key(WidgetsKeys.kEditVehicleScreenTextUpdate),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 53.h),
          ],
        ),
      ),
    );
  }
}
