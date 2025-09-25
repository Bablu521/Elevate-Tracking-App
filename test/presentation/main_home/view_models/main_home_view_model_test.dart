import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_events.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_states.dart';
import 'package:elevate_tracking_app/presentation/main_home/view_models/main_home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MainHomeViewModel mainHomeViewModel;
  late MainHomeStates state;

  setUp(() {
    mainHomeViewModel = MainHomeViewModel();
    state = const MainHomeStates();
  });

  group('testMainHomeViewModel', () {
    test('initial state is MainHomeStates with selectedIndex 0', () {
      expect(mainHomeViewModel.state, state.copyWith(selectedIndex: 0));
    });

    blocTest<MainHomeViewModel, MainHomeStates>(
      'emits new state with updated selectedIndex when BottomNavBarTappedEvent is triggered',
      build: () => MainHomeViewModel(),
      act: (mainHomeViewModel) => mainHomeViewModel.doIntent(BottomNavBarTappedEvent(1)),
      expect: () => [state.copyWith(selectedIndex: 1)],
    );

    blocTest<MainHomeViewModel, MainHomeStates>(
      'emits new state with updated selectedIndex when PageChangedEvent is triggered',
      build: () => MainHomeViewModel(),
      act: (mainHomeViewModel) => mainHomeViewModel.doIntent(PageChangedEvent(2)),
      expect: () => [state.copyWith(selectedIndex: 2)],
    );

    test(
      'does not throw when BottomNavBarTappedEvent is triggered with no clients',
      () {
        mainHomeViewModel = MainHomeViewModel();
        expect(mainHomeViewModel.pageController.hasClients, isFalse);
        expect(
          () => mainHomeViewModel.doIntent(BottomNavBarTappedEvent(1)),
          returnsNormally,
        );
        expect(mainHomeViewModel.state.selectedIndex, 1);
      },
    );

    test('close disposes the pageController', () async {
      await expectLater(mainHomeViewModel.close(), completes);
    });
  });
}
