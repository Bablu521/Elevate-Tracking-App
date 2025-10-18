import 'package:elevate_tracking_app/core/custom_widget/custom_dialog.dart';
import 'package:elevate_tracking_app/presentation/location/view/widget/location_bottom_sheet.dart';
import 'package:elevate_tracking_app/presentation/location/view/widget/location_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/di.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/location_events.dart';
import '../../view_model/location_view_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationViewModel locationViewModel;

  @override
  void initState() {
    super.initState();
    locationViewModel = getIt<LocationViewModel>();
    locationViewModel.doIntent(
      GetOrderLocationEvent(orderId: "68efde9d7fee68a4c2ec2e18", isUser: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationViewModel, LocationState>(
      bloc: locationViewModel,
      listener: (context, state) {
        if (state.errorMessage != null) {
          CustomDialog.positiveButton(
            context: context,
            cancelable: false,
            title: AppLocalizations.of(context).error,
            message: state.errorMessage!,
            positiveOnClick: () {
              context.pop();
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Builder(
            builder: (context) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }
              return LocationViewBody(locationViewModel: locationViewModel);
            },
          ),
          bottomSheet: state.order != null
              ? LocationBottomSheet(
                  orderFirestoreEntity: state.order,
                  isUser: true,
                )
              : null,
        );
      },
    );
  }
}
