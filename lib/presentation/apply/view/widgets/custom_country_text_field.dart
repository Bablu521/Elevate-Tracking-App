import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/utils/validations.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCountryTextField extends StatelessWidget {
  const CustomCountryTextField({super.key});
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ApplyViewModel>(context);
    return BlocBuilder<ApplyViewModel, ApplyViewModelState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          validator: Validations.validateText,
          controller: cubit.controllerCountry,
          style: theme.textTheme.bodyMedium,
          key: const Key(WidgetsKeys.kApplyScreenCountryFormField),
          decoration: InputDecoration(
            label: Text(local.Country),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 7.w),
              child: ValueListenableBuilder(
                valueListenable: cubit.selectedCountry,
                builder: (context, value, child) => SizedBox(
                  width: 10.w,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(3),
                    child: CachedNetworkImage(
                      imageUrl: cubit.selectedCountry.value?.flagImage ?? "",
                      errorWidget: (context, url, error) => const Icon(
                        Icons.public,
                        size: 20,
                        color: AppColors.gray,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            suffixIcon: PopupMenuButton<CountryEntity>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              icon: ImageIcon(
                key: const Key(WidgetsKeys.kApplyScreenArrowDown),
                const AssetImage(AppIcons.iconArrowDown),
                color: theme.colorScheme.secondary,
              ),
              onSelected: (value) {
                cubit.selectedCountry.value = value;
                cubit.controllerCountry.text = value.name;
              },
              itemBuilder: (context) => List.generate(
                state.allCountry?.data?.length ?? 0,
                (index) => PopupMenuItem(
                  value: state.allCountry?.data?[index],
                  child: Row(
                    spacing: 8.sp,
                    children: [
                      SizedBox(
                        width: 30.w,
                        height: 20.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: CachedNetworkImage(
                            imageUrl:
                                state.allCountry?.data?[index].flagImage ?? "",
                            errorWidget: (context, url, error) => const Icon(
                              Icons.public,
                              size: 20,
                              color: AppColors.gray,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        state.allCountry?.data?[index].name ?? "",
                        style: theme.textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
