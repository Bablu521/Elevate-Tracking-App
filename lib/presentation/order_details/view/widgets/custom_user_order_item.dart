import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/custom_cached_network_image.dart';
import 'package:elevate_tracking_app/core/models/track_screen_model.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_event.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_images.dart';

class CustomUserOrderInfoItem extends StatelessWidget {
  const CustomUserOrderInfoItem({
    super.key,
    this.address,
    this.phoneNumber,
    this.name,
    this.imagePath,
    this.orderId,
    required this.isUser,
  });

  final String? address, phoneNumber, name, imagePath, orderId;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: const Key(WidgetsKeys.kOrderDetailsScreenUserOrderInfo),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Row(
          children: [
            (imagePath != null &&
                    imagePath!.isNotEmpty &&
                    imagePath!.startsWith('http'))
                ? ClipOval(
                    key: const Key(
                      WidgetsKeys.kOrderDetailsScreenUserOrderInfoImage,
                    ),
                    child: CustomCachedNetworkImage(
                      imageUrl: imagePath,
                      height: 44.h,
                      width: 44.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(AppImages.defaultProfileImage),
                  ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Text(
                    name ?? "",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gray,
                      fontSize: 13.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    spacing: 2.w,
                    children: [
                      GestureDetector(
                        onTap: () => context.push(
                          RouteNames.locationScreen,
                          extra: TrackScreenModel(
                            orderId: orderId ?? "",
                            isUser: isUser,
                          ),
                        ),
                        child: ImageIcon(
                          const AssetImage(AppIcons.iconLocation),
                          size: 16.sp,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          address ?? "",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 2.w,
              children: [
                GestureDetector(
                  onTap: () =>
                      context.read<OrderDetailsViewModelCubit>().doIntent(
                        OrderDetailsDirectToCallNumber(
                          phoneNumber: phoneNumber ?? "",
                        ),
                      ),
                  child: Icon(
                    Icons.phone_outlined,
                    color: theme.colorScheme.primary,
                    size: 16.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      context.read<OrderDetailsViewModelCubit>().doIntent(
                        OrderDetailsDirectToWhatsApp(
                          phoneNumber: phoneNumber ?? "",
                        ),
                      ),
                  child: SvgPicture.asset(
                    AppIcons.whatsAppICons,
                    width: 17.w,
                    height: 17.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
