import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  int notificationCount = 3;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile , style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            onPressed: () => context.canPop() ? context.pop() : null,
            icon: const Icon(Icons.arrow_back_ios , size: 20,),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none,size: 24,),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: TextStyle(color: AppColors.white, fontSize: 9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const SafeArea(child: ProfileViewBody()),
    );
  }
}