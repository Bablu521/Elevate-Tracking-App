import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_event.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/custom_widget/custom_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/validations.dart';
import '../../../../generated/l10n.dart';
import '../view_model/change_password_states.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late final ChangePasswordViewModel _changePasswordViewModel;
  bool isDialogShow = false;

  @override
  void initState() {
    super.initState();
    _changePasswordViewModel = getIt<ChangePasswordViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            Text(AppLocalizations.of(context).resetPassword),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * width),
        child: BlocConsumer<ChangePasswordViewModel, ChangePasswordStates>(
          bloc: _changePasswordViewModel,
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == ChangePasswordStatus.loading) {
              if (!isDialogShow) {
                isDialogShow = true;
                CustomDialog.loading(context: context);
              }
              return;
            }
            if (isDialogShow) {
              context.pop();
              isDialogShow = false;
            }

            if (state.status == ChangePasswordStatus.error) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).error,
                message: state.errorMessage,
              );
              return;
            }
            if (state.status == ChangePasswordStatus.success) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).success,
                message: state.changePasswordResponseEntity?.message,
                cancelable: false,
                positiveOnClick: () {
                  context.go(RouteNames.resetPassword);
                },
              );
            }
          },

          builder: (BuildContext context, state) {
            return Form(
              key: _changePasswordViewModel.changePasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.h,
                children: [
                  SizedBox(height: 32.h),
                  TextFormField(
                    //current pass
                    key: const Key(WidgetsKeys.kChanePasswordPassword),
                    onChanged: (_) => _changePasswordViewModel.doIntent(
                      CheckAllFieldsEvent(),
                    ),
                    obscureText: true,
                    controller:
                        _changePasswordViewModel.currentPasswordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: Validations.validatePassword,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).currentPassword,
                      hintText: AppLocalizations.of(context).currentPassword,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    //new pass
                    key: const Key(WidgetsKeys.kChanePasswordNewPassword),
                    onChanged: (_) => _changePasswordViewModel.doIntent(
                      CheckAllFieldsEvent(),
                    ),
                    obscureText: true,
                    controller: _changePasswordViewModel.newPasswordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: Validations.validatePassword,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).newPassword,
                      hintText: AppLocalizations.of(context).newPassword,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    //confirm pass
                    key: const Key(WidgetsKeys.kChanePasswordConfirmPassword),
                    onChanged: (_) => _changePasswordViewModel.doIntent(
                      CheckAllFieldsEvent(),
                    ),
                    obscureText: true,
                    controller:
                        _changePasswordViewModel.confirmPasswordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: (val) {
                      return Validations.validateConfirmPassword(
                        val,
                        _changePasswordViewModel.newPasswordController.text,
                      );
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).confirmPassword,
                      hintText: AppLocalizations.of(context).confirmPassword,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  ElevatedButton(
                    key: const Key(WidgetsKeys.kChanePasswordConfirmButton),
                    onPressed: state.status == ChangePasswordStatus.loading
                        ? null
                        : state.isButtonEnabled
                        ? () => _changePasswordViewModel.doIntent(
                            ChangePasswordEvent(),
                          )
                        : null,
                    child: Text(
                      AppLocalizations.of(context).confirm,
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
