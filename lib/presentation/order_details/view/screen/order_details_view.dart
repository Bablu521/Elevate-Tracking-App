import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/order_details/view/widgets/order_details_body_builder.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_event.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsView extends StatelessWidget {
  final String orderId;
  const OrderDetailsView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          key: const Key(WidgetsKeys.kOrderDetailsScreenLabelAppBar),
          AppLocalizations.of(context).orderDetails,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            key: Key(WidgetsKeys.kOrderDetailsScreenIconArrowBack),
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<OrderDetailsViewModelCubit>()
          ..doIntent(
            OrderDetailsGetOrderFromFireBase(
              orderId: orderId,
            ),
          ),
        child: const OrderDetailsBodyBuilder(),
      ),
    );
  }
}
