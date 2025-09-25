import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/custom_widget/custom_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/validations.dart';
import '../view_model/forget_password_event.dart';
import '../view_model/forget_password_states.dart';
import '../view_model/forget_password_view_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final ForgetPasswordViewModel _forgetPasswordViewModel;
  bool isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();
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
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * width),
        child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: _forgetPasswordViewModel,

          listener: (context, state) {
            if (!state.isLoading && isDialogVisible) {
             context.go(RouteNames.emailVerification);
              isDialogVisible = false;
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).emailIsCorrect,
                message: state.errorMessage,
              );
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
                message:
                    AppLocalizations.of(context).passwordResetSuccessfully,
                cancelable: false,
                positiveOnClick: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.login,
                  (route) => false,
                ),
              );
            }
          },

          builder: (BuildContext context, state) {
            return Form(
              key: _forgetPasswordViewModel.forgetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 0.05 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).forgetPassword,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                    ),
                  ),
                  SizedBox(height: 0.02 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).pleaseenteryouremailassociatedto,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                    ),
                  ),
                  SizedBox(height: 0.005 * height),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).yourAccount,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                    ),
                  ),
                  SizedBox(height: 0.05 * height),
                  TextFormField(
                    controller: _forgetPasswordViewModel.emailController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: Validations.validateEmail,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email,
                      hintText: AppLocalizations.of(context).enterYouEmail,
                    ),
                  ),
                  SizedBox(height: 0.05 * height),
                  SizedBox(
                    height: 0.055 * height,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_forgetPasswordViewModel.forgetPasswordFormKey.currentState!.validate()) {
                          _forgetPasswordViewModel.doIntent(
                            ForgetPasswordEvent(),
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context).confirm),
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
