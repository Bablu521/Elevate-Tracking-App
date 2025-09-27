import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/validations.dart';
import '../../../../../generated/l10n.dart';
import '../../view_models/forget_password_events.dart';
import '../../view_models/forget_password_view_model.dart';

class ForgetPasswordResetPassword extends StatelessWidget {
  final ForgetPasswordViewModel forgetPasswordViewModel;

  const ForgetPasswordResetPassword({
    super.key,
    required this.forgetPasswordViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgetPasswordViewModel.resetPasswordFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.h,
          children: [
            SizedBox(height: 32.h),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context).resetPassword,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context).passwordMustNotEmpty,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              obscureText: true,
              controller: forgetPasswordViewModel.newPasswordController,
              style: Theme.of(context).textTheme.bodySmall,
              validator: Validations.validatePassword,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).newPassword,
                hintText: AppLocalizations.of(context).enterYourPassword,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              obscureText: true,
              controller: forgetPasswordViewModel.confirmPasswordController,
              style: Theme.of(context).textTheme.bodySmall,
              validator: (value) {
                return Validations.validateConfirmPassword(
                  value,
                  forgetPasswordViewModel.newPasswordController.text,
                );
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).confirmPassword,
                hintText: AppLocalizations.of(context).confirmPassword,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                if (forgetPasswordViewModel.resetPasswordFormKey.currentState!
                    .validate()) {
                  forgetPasswordViewModel.doIntent(ResetPasswordEvent());
                }
              },
              child: Text(AppLocalizations.of(context).confirm),
            ),
          ],
        ),
      ),
    );
  }
}
