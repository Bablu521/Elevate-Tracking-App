import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/custom_widget/custom_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/router/route_names.dart';
import '../../../../generated/l10n.dart';
import '../view_model/forget_password_event.dart';
import '../view_model/forget_password_states.dart';
import '../view_model/forget_password_view_model.dart';

class EmailVerification extends StatefulWidget {
  final String? email;
  const EmailVerification({super.key, this.email});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late final ForgetPasswordViewModel _forgetPasswordViewModel;
  bool isDialogShow = false;

  @override
  void initState() {
    super.initState();
    _forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();
    _forgetPasswordViewModel.savedEmail = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
            Text(AppLocalizations.of(context).password),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.01 * width),
        child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: _forgetPasswordViewModel,
          listener: (context, state) {
            if (isDialogShow == true) {
              context.pop();
              isDialogShow = false;
            }
            if (state.isLoading) {
              isDialogShow = true;
              CustomDialog.loading(context: context);
            } else if (state.errorMessage != null) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).error,
                message: state.errorMessage,
              );
            } else {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).success,
                message: AppLocalizations.of(context).codeVerifiedSuccessfully,
                cancelable: false,
                positiveOnClick: () {
                  context.go(RouteNames.resetPassword);
                },
              );
            }
          },

          builder: (BuildContext context, state) {
            return Form(
              key: _forgetPasswordViewModel.forgetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 0.05 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).emailVerification,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                    ),
                  ),
                  SizedBox(height: 0.02 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(
                        context,
                      ).pleaseenteryourcodethatsendtoyour,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                    ),
                  ),
                  SizedBox(height: 0.005 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).emailAddress,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                    ),
                  ),
                  SizedBox(height: 0.05 * height),
                  Pinput(
                    keyboardType: TextInputType.number,
                    pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                    length: 6,
                    controller: _forgetPasswordViewModel.resetCodeController,
                    onSubmitted: (_) {
                      if (_forgetPasswordViewModel
                              .resetCodeController
                              .text
                              .length <
                          6) {
                        _forgetPasswordViewModel
                            .verifyResetCodeFormKey
                            .currentState
                            ?.validate();
                      } else {
                        _forgetPasswordViewModel.doIntent(
                          VerifyResetCodeEvent(),
                        );
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
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return AppLocalizations.of(context).invalidCode;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 0.1 * height),
                  InkWell(
                    onTap: () {
                      _forgetPasswordViewModel.doIntent(ForgetPasswordEvent(email: _forgetPasswordViewModel.savedEmail));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          AppLocalizations.of(context).didnotReceiveCode,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.black),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          AppLocalizations.of(context).resend,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppColors.mainColor,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
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
