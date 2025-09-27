import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_events.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainHomeViewModel extends Cubit<MainHomeStates> {
  MainHomeViewModel() : super(const MainHomeStates());

  final PageController pageController = PageController();

  void doIntent(MainHomeEvent event) {
    switch (event) {
      case BottomNavBarTappedEvent():
        _bottomNavBarOnTap(event.index);
        break;
      case PageChangedEvent():
        _onPageChanged(event.index);
        break;
    }
  }

  void _bottomNavBarOnTap(int index) {
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
    emit(state.copyWith(selectedIndex: index));
  }

  void _onPageChanged(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
