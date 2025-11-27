import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../view_model/location_view_model.dart';

class LocationViewBody extends StatelessWidget {
  final LocationViewModel locationViewModel;

  const LocationViewBody({super.key, required this.locationViewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 40.h),
          child: GoogleMap(
            onMapCreated: (controller) {
              locationViewModel.mapController = controller;
            },
            markers: locationViewModel.state.markers,
            polylines: locationViewModel.state.polylines,
            initialCameraPosition: CameraPosition(
              target: locationViewModel.currentLocation,
              zoom: 12,
            ),
          ),
        ),
        Positioned(
          left: 10.w,
          top: 32.h,
          child: ElevatedButton(
            onPressed: () {
              context.pop();
            },
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: WidgetStateProperty.all(const CircleBorder()),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Icon(Icons.arrow_back_ios, size: 20.sp),
            ),
          ),
        ),
      ],
    );
  }
}
