import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_events.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_profile_image_section.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/edit_profile_info_form.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/gender_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class EditProfileInfoViewBody extends StatelessWidget {
  EditProfileInfoViewBody({super.key});

  final ProfileViewModel profileViewModel = getIt.get<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      bloc: profileViewModel,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 36.h),
                EditProfileImageSection(profileViewModel: profileViewModel),
                SizedBox(height: 29.h),
                EditProfileInfoForm(profileViewModel: profileViewModel),
                SizedBox(height: 24.h),
                GenderRadioListTile(profileViewModel: profileViewModel),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 48.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isFormChanged
                          ? AppColors.mainColor
                          : AppColors.black[30],
                    ),
                    onPressed: () {
                      state.isFormChanged
                          ? {
                              if (profileViewModel.formKey.currentState!
                                  .validate())
                                {
                                  profileViewModel.doIntent(
                                    OnEditProfileEvent(),
                                  ),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppColors.green,
                                      content: Center(
                                        child: Text(
                                          "Profile updated successfully",
                                        ),
                                      ),
                                    ),
                                  ),
                                },
                            }
                          : null;
                    },
                    child: Text(
                      AppLocalizations.of(context).update,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
