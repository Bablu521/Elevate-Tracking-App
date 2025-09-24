import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/login_events.dart';

class LoginFooterSection extends StatelessWidget {
  final LoginViewModel loginViewModel;

  const LoginFooterSection({super.key, required this.loginViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
              valueListenable: loginViewModel.isRememberMe,
              builder: (context, value, child) {
                return Expanded(
                  child: CheckboxListTile(
                    side: BorderSide(color: AppColors.black),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    title: Text(
                      AppLocalizations.of(context).rememberMe,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: value,
                    onChanged: (value) {
                      loginViewModel.doIntent(RememberMeEvent(value!));
                    },
                  ),
                );
              },
            ),
            InkWell(
              onTap: () {},
              child: Text(
                AppLocalizations.of(context).forgotPasswordWithQuestionMark,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: loginViewModel.isButtonEnabled,
          builder: (context, value, child) {
            return ElevatedButton(
              onPressed: value == true
                  ? () {
                      if (loginViewModel.formKey.currentState!.validate()) {
                        loginViewModel.doIntent(RequestLoginEvent());
                      }
                    }
                  : null,
              child: Text(
                AppLocalizations.of(context).continueWord,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
