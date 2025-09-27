import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/validations.dart';
import '../../../../../generated/l10n.dart';
import '../../view_models/forget_password_events.dart';
import '../../view_models/forget_password_view_model.dart';

class ForgetPasswordForm extends StatelessWidget {
  final ForgetPasswordViewModel forgetPasswordViewModel;

  const ForgetPasswordForm({super.key, required this.forgetPasswordViewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgetPasswordViewModel.forgetPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.h,
        children: [
          SizedBox(height: 32.h),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context).forgetPassword,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context).pleaseEnterYourEmail,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: forgetPasswordViewModel.emailController,
            style: Theme.of(context).textTheme.bodySmall,
            validator: Validations.validateEmail,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).email,
              hintText: AppLocalizations.of(context).enterYourEmail,
            ),
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            onPressed: () {
              if (forgetPasswordViewModel.forgetPasswordFormKey.currentState!
                  .validate()) {
                forgetPasswordViewModel.doIntent(ForgetPasswordEvent());
              }
            },
            child: Text(AppLocalizations.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
