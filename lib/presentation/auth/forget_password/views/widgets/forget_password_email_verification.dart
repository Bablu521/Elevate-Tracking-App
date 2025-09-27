import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../view_models/forget_password_events.dart';
import '../../view_models/forget_password_view_model.dart';

class ForgetPasswordEmailVerification extends StatelessWidget {
  final ForgetPasswordViewModel forgetPasswordViewModel;

  const ForgetPasswordEmailVerification({
    super.key,
    required this.forgetPasswordViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgetPasswordViewModel.emailVerificationFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.h,
        children: [
          SizedBox(height: 32.h),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context).emailVerification,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context).pleaseEnterYourVerificationCode,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColors.gray),
          ),
          SizedBox(height: 16.h),
          Pinput(
            keyboardType: TextInputType.number,
            pinputAutovalidateMode: PinputAutovalidateMode.disabled,
            length: 6,
            controller: forgetPasswordViewModel.resetCodeController,
            onSubmitted: (_) {
              if (forgetPasswordViewModel.resetCodeController.text.length < 6) {
                forgetPasswordViewModel.emailVerificationFormKey.currentState
                    ?.validate();
              } else {
                forgetPasswordViewModel.doIntent(EmailVerificationEvent());
              }
            },
            defaultPinTheme: PinTheme(
              width: MediaQuery.of(context).size.width / 6,
              height: 70.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: AppColors.white[60],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            errorPinTheme: PinTheme(
              width: MediaQuery.of(context).size.width / 6,
              height: 70.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.red),
              ),
            ),
            validator: (_) {
              return AppLocalizations.of(context).invalidCode;
            },
          ),
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context).didNotReceiveCode,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: () {
                    forgetPasswordViewModel.doIntent(ForgetPasswordEvent());
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context).resend,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.mainColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
