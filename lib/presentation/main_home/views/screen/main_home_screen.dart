import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/app_icons.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_events.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_states.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_view_model.dart';
import 'package:elevate_tracking_app/presentation/main_home/views/widgets/custom_nav_bar_icon.dart';
import 'package:elevate_tracking_app/presentation/main_home/views/widgets/custom_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeScreen extends StatelessWidget {
  MainHomeScreen({super.key});

  final MainHomeViewModel mainHomeViewModel = getIt.get<MainHomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainHomeViewModel, MainHomeStates>(
      bloc: mainHomeViewModel,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: mainHomeViewModel.state.selectedIndex,
            onTap: (index) {
              mainHomeViewModel.doIntent(BottomNavBarTappedEvent(index));
            },
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: AppColors.white[80],
            items: [
              BottomNavigationBarItem(
                icon: CustomNavBarIcon(
                  imagePath: AppIcons.iconHomeTab,
                  isSelected: mainHomeViewModel.state.selectedIndex == 0,
                ),
                label: AppLocalizations.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: CustomNavBarIcon(
                  imagePath: AppIcons.iconOrdersTab,
                  isSelected: mainHomeViewModel.state.selectedIndex == 1,
                ),
                label: AppLocalizations.of(context).orders,
              ),
              BottomNavigationBarItem(
                icon: CustomNavBarIcon(
                  imagePath: AppIcons.iconProfileTab,
                  isSelected: mainHomeViewModel.state.selectedIndex == 2,
                ),
                label: AppLocalizations.of(context).profile,
              ),
            ],
          ),
          body: SafeArea(
            child: CustomPageView(mainHomeViewModel: mainHomeViewModel),
          ),
        );
      },
    );
  }
}
