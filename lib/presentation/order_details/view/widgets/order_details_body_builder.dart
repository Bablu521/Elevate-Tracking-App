import 'package:elevate_tracking_app/presentation/order_details/view/widgets/order_details_body.dart';
import 'package:flutter/material.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_view_model_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsBodyBuilder extends StatelessWidget {
  const OrderDetailsBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<OrderDetailsViewModelCubit, OrderDetailsViewModelState>(
      buildWhen: (previous, current) =>
          previous.orderDetails != current.orderDetails,
      builder: (context, state) {
        if (state.orderDetails?.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        } else if (state.orderDetails?.errorMessage != null) {
          return Center(
            child: Text(
              state.orderDetails!.errorMessage!,
              style: theme.textTheme.bodyMedium,
            ),
          );
        }
        return OrderDetailsBody(orderFirestoreEntity: state.orderDetails?.data);
      },
    );
  }
}
