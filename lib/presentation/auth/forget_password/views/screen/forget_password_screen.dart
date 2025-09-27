import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widget/custom_dialog.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../generated/l10n.dart';
import '../../view_models/forget_password_state.dart';
import '../../view_models/forget_password_view_model.dart';
import '../widgets/forget_password_email_verification.dart';
import '../widgets/forget_password_form.dart';
import '../widgets/forget_password_reset_password.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final ForgetPasswordViewModel _forgetPasswordViewModel;

  bool isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).password),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: _forgetPasswordViewModel,
          listener: (context, state) {
            if (!state.isLoading && isDialogVisible) {
              context.pop();
              isDialogVisible = false;
            }

            if (state.isLoading && !isDialogVisible) {
              isDialogVisible = true;
              CustomDialog.loading(context: context);
            } else if (state.errorMessage != null) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).error,
                message: state.errorMessage,
              );
            }

            if (state.isSuccess) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).success,
                message: AppLocalizations.of(context).passwordResetSuccessfully,
                cancelable: false,
                positiveOnClick: () => context.go(RouteNames.login),
              );
            }
          },
          builder: (context, state) {
            if (state.pageNumber == 0) {
              return ForgetPasswordForm(
                forgetPasswordViewModel: _forgetPasswordViewModel,
              );
            } else if (state.pageNumber == 1) {
              if (state.validateResetCode) {
                _forgetPasswordViewModel.emailVerificationFormKey.currentState
                    ?.validate();
              }
              return ForgetPasswordEmailVerification(
                forgetPasswordViewModel: _forgetPasswordViewModel,
              );
            } else if (state.pageNumber == 2) {
              return ForgetPasswordResetPassword(
                forgetPasswordViewModel: _forgetPasswordViewModel,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
