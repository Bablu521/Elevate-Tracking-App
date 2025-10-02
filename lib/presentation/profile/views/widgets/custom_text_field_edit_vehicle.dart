import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldEditVehicle extends StatelessWidget {
  const CustomTextFieldEditVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<EditVehicleViewModel>(context);
    return BlocBuilder<EditVehicleViewModel, EditVehicleViewModelState>(
      builder: (context, state) {
        return TextFormField(
          controller: cubit.controllerVehicleType,
          validator: Validations.validateText,
          style: theme.textTheme.bodyMedium,
          readOnly: true,
          key: const Key(WidgetsKeys.kEditVehicleScreenVehicleTypeFormField),
          decoration: InputDecoration(
            label: Text(local.vehicleType),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                height: 30.h,
                width: 30.w,
                child: ValueListenableBuilder<VehicleEntity?>(
                  valueListenable: cubit.selectedVehicle,
                  builder: (context, value, child) {
                    return CachedNetworkImage(
                      imageUrl: cubit.selectedVehicle.value?.image ?? "",
                      placeholder: (context, url) => const Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.gray,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.gray,
                      ),
                    );
                  },
                ),
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: PopupMenuButton<VehicleEntity>(
                icon: ImageIcon(
                  key: const Key(WidgetsKeys.kEditVehicleScreenArrowDown),
                  const AssetImage(AppIcons.iconArrowDown),
                  color: theme.colorScheme.secondary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                onSelected: (value) {
                  cubit.selectedVehicle.value = value;
                  cubit.controllerVehicleType.text = value.type ?? "";
                },
                itemBuilder: (context) => List.generate(
                  state.allVehicleList?.data?.length ?? 0,
                  (index) => PopupMenuItem(
                    value: state.allVehicleList?.data?[index],
                    child: Row(
                      spacing: 10.sp,
                      children: [
                        SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: CachedNetworkImage(
                            imageUrl:
                                state.allVehicleList?.data?[index].image ?? "",
                            placeholder: (context, url) => const Icon(
                              Icons.directions_car_outlined,
                              color: AppColors.gray,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.directions_car_outlined,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                        Text(
                          state.allVehicleList?.data?[index].type ?? "",
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
