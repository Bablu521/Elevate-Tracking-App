import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/widgets_keys.dart';
import '../../../../core/di/di.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../view_model/home_events.dart';
import '../widget/home_order_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    homeViewModel = getIt.get<HomeViewModel>();
    homeViewModel.doIntent(GetOrdersEvent());
  }

  @override
  void dispose() {
    homeViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      bloc: homeViewModel,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        if (state.isAcceptSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).orderAcceptedSuccessfully,
              ),
            ),
          );
        }
        if (state.isFinish) {
          context.replace(RouteNames.orderDetails, extra: state.orderId);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.ordersList == null || state.ordersList!.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context).noOrders));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 16.h),
              child: Text(
                AppLocalizations.of(context).floweryRider,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: ConstKeys.iMFeellEnglishFont,
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !state.isLoadingMore) {
                    homeViewModel.doIntent(LoadMoreOrdersEvent());
                  }
                  return true;
                },
                child: ListView.separated(
                  key: const Key(WidgetsKeys.kHomePageListView),
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  itemCount: state.ordersList?.length ?? 0,
                  itemBuilder: (ctx, index) {
                    return HomeOrderCard(
                      key: Key(state.ordersList?[index].id ?? ""),
                      index: index,
                      orderEntity:
                          state.ordersList?[index] ?? const OrderEntity(),
                      homeViewModel: homeViewModel,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.h);
                  },
                ),
              ),
            ),
            if (state.isLoadingMore)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
