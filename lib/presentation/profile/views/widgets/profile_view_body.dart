import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_events.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/logout_dialog.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/profile_details_card.dart';
import 'package:elevate_tracking_app/presentation/profile/views/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final ProfileViewModel profileViewModel = getIt.get<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    profileViewModel.doIntent(OnGetLoggedDriverDataUseCaseEvent());
  }

  late DriverEntity driverEntity;
  late VehicleEntity vehicleEntity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileStates>(
      bloc: profileViewModel,
      listener: (context, state) {
        if (state.driverData != null && state.vehicleData == null) {
          profileViewModel.doIntent(
            OnGetVehicleEvent(id: state.driverData!.vehicleType!),
          );
        }
      },
      builder: (context, state) {
        if (state.driverData != null && state.vehicleData != null) {
          driverEntity = state.driverData!;
          vehicleEntity = state.vehicleData!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 31.h),
                ProfileDetailsCard(driverEntity: driverEntity),
                SizedBox(height: 24.h),
                VehicleInfoCard(
                  driverEntity: driverEntity,
                  vehicleEntity: vehicleEntity,
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 16.h,
                            width: 16.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppIcons.iconLanguage),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppLocalizations.of(context).language,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context).english,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 16.h,
                            width: 16.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppIcons.iconLogoutSmall),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppLocalizations.of(context).logout,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => LogoutDialog(
                              onLogout: () {
                                profileViewModel.doIntent(OnLogoutEvent());
                                context.go(RouteNames.login);
                              },
                            ),
                          );
                        },
                        child: Container(
                          key: const Key(WidgetsKeys.kProfileScreenLogoutIcon),
                          height: 24.h,
                          width: 24.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppIcons.iconLogoutLarge),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.errorMessage != null) {
          return Center(
            key: const Key(WidgetsKeys.kProfileScreenErrorMessage),
            child: Text(state.errorMessage!),
          );
        } else if (state.isLoading) {
          return const Center(
            key: Key(WidgetsKeys.kProfileScreenLoadingIndicator),
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
