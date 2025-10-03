import 'dart:io';
import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_events.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileImageSection extends StatelessWidget {
  final ProfileViewModel profileViewModel;
  const EditProfileImageSection({super.key,required this.profileViewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 79.h,
            width: 74.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: profileViewModel.state.localPickedImage != null
                    ? FileImage(profileViewModel.state.localPickedImage!)
                          as ImageProvider
                    : NetworkImage(
                        profileViewModel.state.driverData?.photo ?? '',
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
               onTap: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  profileViewModel.doIntent(OnUploadProfileImageEvent(file: (File(pickedFile.path))));
                }
              },
              child: Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  color: AppColors.lightPink,
                  image: const DecorationImage(
                    image: AssetImage(AppIcons.iconCameraEditProfile),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
