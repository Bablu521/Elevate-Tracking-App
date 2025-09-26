import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view/widget/login_body_section.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widget/custom_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/login_events.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _loginViewModel;

  bool isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _loginViewModel = getIt<LoginViewModel>();
    _loginViewModel.doIntent(LoadSavedUserDataEvent());
  }

  @override
  void dispose() {
    _loginViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).login),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            key: const Key(WidgetsKeys.kLoginScreenAppBarButton),
            onPressed: () => context.canPop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: BlocListener<LoginViewModel, LoginState>(
        bloc: _loginViewModel,
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
          } else if (state.isLoggedIn) {
            context.go(RouteNames.mainHome);
          }
        },
        child: LoginBodySection(loginViewModel: _loginViewModel),
      ),
    );
  }
}
