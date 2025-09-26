import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/custom_dialog.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/custom_apply_radio.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/custom_country_text_field.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/custom_password_field.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/custom_vehicle_type_text_filed.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ApplyBody extends StatelessWidget {
  const ApplyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ApplyViewModel>(context);
    return BlocListener<ApplyViewModel, ApplyViewModelState>(
      listener: (context, state) {
        if (state.applyFun?.isLoading == true) {
          CustomDialog.loading(context: context);
        } else if (state.applyFun?.data != null) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("success")),
          ); // when success must be navigate to apply success
        } else if (state.applyFun?.errorMessage != null) {
          context.pop();
          CustomDialog.positiveButton(
            context: context,
            cancelable: true,
            title: state.applyFun?.errorMessage,
          );
        }
      },
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: cubit.globalKey,
        child: Padding(
          key: const Key(WidgetsKeys.kApplyScreenPadding),
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: SingleChildScrollView(
            key: const Key(WidgetsKeys.kApplyScreenSingleChildScrollView),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key: const Key(WidgetsKeys.kApplyScreenPadding),
                  local.welcome,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  key: const Key(WidgetsKeys.kApplyScreenDescription),
                  local.youWantToBeADeliveryManJoinOurTeam,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                  ),
                ),
                SizedBox(height: 32.h),
                const CustomCountryTextField(),
                SizedBox(height: 25.h),
                TextFormField(
                  controller: cubit.controllerFirstName,
                  validator: Validations.validateText,
                  style: theme.textTheme.bodyMedium,

                  key: const Key(WidgetsKeys.kApplyScreenFirstNamedFormField),
                  decoration: InputDecoration(
                    label: Text(local.firstLegalName),
                    hintText: local.EnterFirstLegalName,
                  ),
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  validator: Validations.validateText,
                  style: theme.textTheme.bodyMedium,

                  controller: cubit.controllerSecondName,
                  key: const Key(WidgetsKeys.kApplyScreenSecondNamedFormField),
                  decoration: InputDecoration(
                    label: Text(local.secondLegalName),
                    hintText: local.EnterSecondLegalName,
                  ),
                ),
                SizedBox(height: 25.h),
                const CustomVehicleTypeTextFiled(),
                SizedBox(height: 25.h),
                TextFormField(
                  controller: cubit.controllerVehicleNumber,
                  validator: Validations.validateText,
                  style: theme.textTheme.bodyMedium,
                  key: const Key(
                    WidgetsKeys.kApplyScreenVehicleNumberFormField,
                  ),
                  decoration: InputDecoration(
                    label: Text(local.vehicleNumber),
                    hintText: local.enterVehicleNumber,
                  ),
                ),
                SizedBox(height: 25.h),
                BlocBuilder<ApplyViewModel, ApplyViewModelState>(
                  builder: (context, state) {
                    return TextFormField(
                      style: theme.textTheme.bodyMedium,
                      validator: Validations.validateText,
                      controller: cubit.controllerVehicleLicense,
                      key: const Key(
                        WidgetsKeys.kApplyScreenVehicleLicenseFormField,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: state.vehicleImagePath != null
                            ? const Icon(Icons.task_alt, color: AppColors.green)
                            : null,
                        label: Text(local.vehicleLicense),
                        hintText: local.uploadLicensePhoto,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            cubit.doIntent(ApplyEventPickVehicleLicensePhoto());
                          },
                          child: ImageIcon(
                            key: const Key(WidgetsKeys.kApplyScreenIconUpload),
                            const AssetImage(AppIcons.iconUpload),
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  controller: cubit.controllerEmail,
                  style: theme.textTheme.bodyMedium,
                  validator: Validations.validateEmail,
                  key: const Key(WidgetsKeys.kApplyScreenEmailFormField),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(local.email),
                    hintText: local.enterYourEmail,
                  ),
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  style: theme.textTheme.bodyMedium,
                  validator: Validations.validatePhoneNumber,
                  controller: cubit.controllerPhoneNumber,
                  key: const Key(WidgetsKeys.kApplyScreenPhoneNumberFormField),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(local.phoneNumber),
                    hintText: local.enterYourPhoneNumber,
                  ),
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  style: theme.textTheme.bodyMedium,
                  validator: Validations.validateFourteenDigitNumber,
                  controller: cubit.controllerIdNumber,
                  key: const Key(WidgetsKeys.kApplyScreenIDNumberFormField),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(local.nidNumber),
                    hintText: local.enterIdNumber,
                  ),
                ),
                SizedBox(height: 25.h),
                BlocBuilder<ApplyViewModel, ApplyViewModelState>(
                  builder: (context, state) {
                    return TextFormField(
                      readOnly: true,
                      style: theme.textTheme.bodyMedium,
                      validator: Validations.validateText,
                      controller: cubit.controllerIdImage,
                      key: const Key(WidgetsKeys.kApplyScreenIDImageFormField),
                      decoration: InputDecoration(
                        prefixIcon: state.idImagePath != null
                            ? const Icon(Icons.task_alt, color: AppColors.green)
                            : null,
                        label: Text(local.nidImage),
                        hintText: local.uploadIdImage,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            cubit.doIntent(ApplyEventPickIDImage());
                          },
                          child: ImageIcon(
                            key: const Key(WidgetsKeys.kApplyScreenIconUpload),
                            const AssetImage(AppIcons.iconUpload),
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 25.h),
                const CustomPasswordField(),
                SizedBox(height: 25.h),
                const CustomApplyRadio(),
                SizedBox(height: 25.h),
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: cubit.isUserAuthenticated,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        key: const Key(
                          WidgetsKeys.kApplyScreenElevatedButtonContinue,
                        ),
                        onPressed: value
                            ? () => cubit.doIntent(ApplyValidationField())
                            : null,
                        child: Text(
                          local.continueText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 22.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
