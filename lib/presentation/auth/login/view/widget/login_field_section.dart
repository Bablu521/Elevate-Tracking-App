import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/validations.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/login_events.dart';

class LoginFieldSection extends StatelessWidget {
  final LoginViewModel loginViewModel;

  const LoginFieldSection({super.key, required this.loginViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        TextFormField(
          controller: loginViewModel.emailController,
          style: Theme.of(context).textTheme.bodySmall,
          validator: Validations.validateEmail,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).email,
            hintText: AppLocalizations.of(context).enterYourEmail,
          ),
          onChanged: textFormFieldChanged,
        ),
        ValueListenableBuilder(
          valueListenable: loginViewModel.isPasswordVisible,
          builder: (context, value, child) {
            return TextFormField(
              obscureText: !value,
              controller: loginViewModel.passwordController,
              style: Theme.of(context).textTheme.bodySmall,
              validator: Validations.validatePassword,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).password,
                hintText: AppLocalizations.of(context).enterYourPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    loginViewModel.doIntent(TogglePasswordVisibilityEvent());
                  },
                  icon: Icon(
                    value == true ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.gray,
                  ),
                ),
              ),
              onChanged: textFormFieldChanged,
            );
          },
        ),
      ],
    );
  }

  void textFormFieldChanged(String _) {
    loginViewModel.doIntent(LoginButtonStatusEvent());
  }
}
