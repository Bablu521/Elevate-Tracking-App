import 'package:elevate_tracking_app/presentation/auth/login/view/widget/login_field_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/login_view_model.dart';
import 'login_footer_section.dart';

class LoginBodySection extends StatelessWidget {
  final LoginViewModel loginViewModel;

  const LoginBodySection({super.key, required this.loginViewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginViewModel.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          spacing: 16.h,
          children: [
            LoginFieldSection(loginViewModel: loginViewModel),
            LoginFooterSection(loginViewModel: loginViewModel),
          ],
        ),
      ),
    );
  }
}
