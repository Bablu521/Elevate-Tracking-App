import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/custom_widget/custom_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/validations.dart';
import '../../../../generated/l10n.dart';
import '../view_model/forget_password_event.dart';
import '../view_model/forget_password_states.dart';
import '../view_model/forget_password_view_model.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final ForgetPasswordViewModel _forgetPasswordViewModel;
  bool isDialogShow = false;

  @override
  void initState() {
    super.initState();
    _forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();
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
            Text(AppLocalizations.of(context).password),
          ],
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * width),
        child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: _forgetPasswordViewModel,

          listener: (context, state) {
            if (isDialogShow == true){
              context.pop();
              isDialogShow = false;
            }
            if (state.isLoading) {
              isDialogShow=true;
              CustomDialog.loading(context: context);
            }
            else if(state.errorMessage!=null ) {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).error,
                message: state.errorMessage,
              );
            }
            else {
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context).success,
                message: AppLocalizations.of(context).codeVerifiedSuccessfully,
                cancelable: false,
                positiveOnClick: (){
                  context.go(RouteNames.resetPassword);},
              );
            }
          },

          builder: (BuildContext context, state) {
            return Form(
              key: _forgetPasswordViewModel.forgetPasswordFormKey,
              child:
              Column(
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
                    obscureText: false,
                    controller: _forgetPasswordViewModel.emailController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: Validations.validateEmail,
                    decoration:  InputDecoration(
                      labelText: AppLocalizations.of(context).email,
                      hintText: AppLocalizations.of(context).enterYouEmail,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    obscureText: true,
                    controller: _forgetPasswordViewModel.newPasswordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    validator: Validations.validatePassword,
                    decoration:  InputDecoration(
                      labelText: AppLocalizations.of(context).newPassword,
                      hintText: AppLocalizations.of(context).newPassword,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_forgetPasswordViewModel.forgetPasswordFormKey.currentState!
                          .validate()) {
                        _forgetPasswordViewModel.doIntent(ResetPasswordEvent());
                      }
                    },
                    child: Text(AppLocalizations.of(context).confirm),
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
