import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_events.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_states.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_view_model.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/count_cancelled_completed_orders_section.dart';
import 'package:elevate_tracking_app/presentation/orders/views/widgets/flower_order_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key});

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody> {
  @override
  void initState() {
    super.initState();
    driverOrdersViewModel.doIntent(OnGetAllDriverOrdersEvent());
  }

  final DriverOrdersViewModel driverOrdersViewModel = getIt
      .get<DriverOrdersViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverOrdersViewModel, DriverOrdersStates>(
      bloc: driverOrdersViewModel,
      builder: (context, state) {
        if (state.driverOrdersLoading) {
          return const Center(
            key: Key(WidgetsKeys.kDriverOrdersScreenLoadingIndicator),
            child: CircularProgressIndicator());
        } else if (state.driverOrdersErrorMessage != null) {
          return Center(
            key: const Key(WidgetsKeys.kDriverOrdersScreenErrorMessage),
            child: Text(state.driverOrdersErrorMessage!));
        } else if (state.driverOrdersSuccess.isNotEmpty) {
          final orderList = state.driverOrdersSuccess;
            return SingleChildScrollView(
              key: const Key(WidgetsKeys.kDriverOrdersSuccessState),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    CountCancelledCompletedOrdersSection(orderList: orderList),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context).recentOrders,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        return FlowerOrderCustomCard(
                          driverOrderEntityDriverRelated: orderList[index],
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            );
          }
        else if (state.driverOrdersSuccess.isEmpty) {
          return Center(
            key: const Key(WidgetsKeys.kDriverOrdersSuccessNoOrders),
            child: Text(AppLocalizations.of(context).noOrdersYet));
        } else {
          return const SizedBox();
        }
      },
    );
  } 
}
