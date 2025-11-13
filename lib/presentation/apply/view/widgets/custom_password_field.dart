import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ApplyViewModel>(context);
    return Row(
      spacing: 17.sp,
      children: [
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: cubit.isPasswordVisible,
            builder: (context, value, child) => TextFormField(
              obscureText: cubit.isPasswordVisible.value,
              style: theme.textTheme.bodyMedium,
              controller: cubit.controllerPassword,
              validator: Validations.validatePassword,
              key: const Key(WidgetsKeys.kApplyScreenPasswordFormField),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => cubit.doIntent(ApplyPasswordVisibilityEvent()),
                  child: Icon(
                    value ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.gray,
                    size: 25.sp,
                  ),
                ),
                label: Text(local.password),
                hintText: local.enterPassword,
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: cubit.isPasswordVisible,
            builder: (context, value, child) => TextFormField(
              obscureText: cubit.isPasswordVisible.value,
              style: theme.textTheme.bodyMedium,
              controller: cubit.controllerConfirmPassword,
              key: const Key(WidgetsKeys.kApplyScreenConfirmPasswordFormField),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(local.confirmPassword),
                hintText: local.confirmPassword,
              ),
              validator: (value) => Validations.validateConfirmPassword(
                cubit.controllerPassword.text,
                cubit.controllerConfirmPassword.text,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
