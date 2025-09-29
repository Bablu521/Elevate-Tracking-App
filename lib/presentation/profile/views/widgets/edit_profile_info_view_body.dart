import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_profile_image_section.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_profile_info_form.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/gender_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ignore: must_be_immutable
class EditProfileInfoViewBody extends StatelessWidget {
  const EditProfileInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 36.h),
            const EditProfileImageSection(),
            SizedBox(height: 29.h),
            EditProfileInfoForm(),
            SizedBox(height: 24.h),
            const GenderRadioListTile(),
            SizedBox(height: 40.h),
            SizedBox(
              height: 48.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.black[30]),
                onPressed: (){
                  // update profile info
                }, child: Text(AppLocalizations.of(context).update,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500,color: AppColors.white),))),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
