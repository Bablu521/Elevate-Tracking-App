import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditProfileInfoForm extends StatelessWidget {
  final ProfileViewModel profileViewModel;
  const EditProfileInfoForm({super.key,required this.profileViewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileViewModel.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: profileViewModel.firstNameController,
                  style: Theme.of(context).textTheme.bodySmall,
                  validator: Validations.validateFullName,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).firstName,
                  ),
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: TextFormField(
                  controller: profileViewModel.lastNameController,
                  style: Theme.of(context).textTheme.bodySmall,
                  validator: Validations.validateFullName,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).lastName,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          TextFormField(
            controller: profileViewModel.emailController,
            style: Theme.of(context).textTheme.bodySmall,
            validator: Validations.validateEmail,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).email,
            ),
          ),
          SizedBox(height: 24.h),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: profileViewModel.phoneNumberController,
            style: Theme.of(context).textTheme.bodySmall,
            validator: Validations.validatePhoneNumber,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).phoneNumber,
            ),
          ),
          SizedBox(height: 24.h),
          TextFormField(
            initialValue: "00000000",
            obscureText: true,
            obscuringCharacter: "*",
            readOnly: true,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              suffixIcon: TextButton(
                onPressed: () {
                  context.push(RouteNames.changePassword);
                },
                child: Text(
                  AppLocalizations.of(context).change,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              labelText: AppLocalizations.of(context).password,
            ),
          ),
        ],
      ),
    );
  }
}
