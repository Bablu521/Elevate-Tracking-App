import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/update_vehicle_use_case.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_vehicle_info_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/profile_info_dummy.dart';
import 'edit_vehicle_info_screen_test.mocks.dart';

@GenerateMocks([GetAllVehiclesUseCase, UpdateVehicleUseCase])
void main() {
  group("Test Edit Vehicle Screen", () {
    late MockGetAllVehiclesUseCase mockGetAllVehiclesUseCase;
    // late MockUpdateVehicleUseCase updateVehicleUseCase;
    setUpAll(() {
      configureDependencies();
      mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();
      // updateVehicleUseCase = MockUpdateVehicleUseCase();
      provideDummy<ApiResult<List<VehicleEntity>>>(ApiSuccessResult([]));
    });
    testWidgets("test structure", (tester) async {
      await tester.pumpWidget(
        TestAppWrapper(
          child: EditVehicleInfoScreen(
            driverEntity: ProfileInfoDummy.dummyDriverEntityFake,
          ),
        ),
      );
      when(
        mockGetAllVehiclesUseCase.call(),
      ).thenAnswer((_) async => ApiSuccessResult([]));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleScreenAppBar)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleScreenNotificationIcon)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleInfoScreenArrowBaskIcon)),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const Key(WidgetsKeys.kEditVehicleScreenVehicleTypeFormField),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const Key(WidgetsKeys.kEditVehicleScreenVehicleNumberFormField),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const Key(
            WidgetsKeys.kEditVehicleScreenUpdateVehicleLicenseFormField,
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleElevatedButtonUpdate)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleScreenTextUpdate)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleScreenIconUpload)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(WidgetsKeys.kEditVehicleScreenArrowDown)),
        findsOneWidget,
      );
      expect(find.byType(Text), findsNWidgets(7));
      expect(find.byType(Spacer), findsOneWidget);
    });
    // testWidgets("shows validation message when field is empty", (tester) async {
    //   final cubit = EditVehicleViewModel(
    //     mockGetAllVehiclesUseCase,
    //     updateVehicleUseCase,
    //   );

    //   cubit.isUserAuthenticated.value = true;

    //   when(
    //     mockGetAllVehiclesUseCase.call(),
    //   ).thenAnswer((_) async => ApiSuccessResult([]));

    //   await tester.pumpWidget(
    //     TestAppWrapper(
    //       child: EditVehicleInfoScreen(
    //         driverEntity: ProfileInfoDummy.dummyDriverEntityFake,
    //       ),
    //     ),
    //   );

    //   await tester.pumpAndSettle();

    //   // Find widgets
    //   final fieldVehicleNumber = find.byKey(
    //     const Key(WidgetsKeys.kEditVehicleScreenVehicleNumberFormField),
    //   );
    //   final buttonFinder = find.byKey(
    //     const Key(WidgetsKeys.kEditVehicleElevatedButtonUpdate),
    //   );

    //   await tester.enterText(fieldVehicleNumber, '');
    //   await tester.pump();

    //   await tester.tap(buttonFinder);
    //   await tester.pumpAndSettle();

    //   expect(find.byType(Text), findsNWidgets(8));
    // });
  });
}
