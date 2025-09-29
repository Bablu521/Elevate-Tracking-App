import 'package:elevate_tracking_app/presentation/home/views/screen/home_screen.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_events.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_view_model.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/orders_screen.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  final MainHomeViewModel mainHomeViewModel;
  const CustomPageView({super.key, required this.mainHomeViewModel});

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (index) {
        mainHomeViewModel.doIntent(PageChangedEvent(index));
      },
      scrollDirection: Axis.horizontal,
      controller: mainHomeViewModel.pageController,
      children: [
        const HomeScreen(),
        const OrdersScreen(),
        const ProfileScreen(),
      ],
    );
  }
}
