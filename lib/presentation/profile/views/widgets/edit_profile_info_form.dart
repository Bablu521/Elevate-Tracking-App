import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class EditProfileInfoForm extends StatelessWidget {
  EditProfileInfoForm({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
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
                  controller: lastNameController,
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
            controller: emailController,
            style: Theme.of(context).textTheme.bodySmall,
            validator: Validations.validateEmail,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).email,
            ),
          ),
          SizedBox(height: 24.h),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneNumberController,
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
