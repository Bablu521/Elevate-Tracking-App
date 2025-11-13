import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/presentation/apply/view/screen/apply_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/apply_fixture.dart';
import 'apply_view_test.mocks.dart';

@GenerateMocks([GetAllVehiclesUseCase])
void main() {
  late MockGetAllVehiclesUseCase mockGetAllVehiclesUseCase;
  ApplyFixture.fakeResponseEntity();
  final List<VehicleEntity> vehicleResponseEntity =
      ApplyFixture.fakeVehicleEntity();
  final List<CountryEntity> countryResponseEntity =
      ApplyFixture.fakeCountryEntityList();
  ApplyFixture.fakeRequestEntity();
  setUp(() {
    configureDependencies();
    mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();
    provideDummy<ApiResult<List<VehicleEntity>>>(
      ApiSuccessResult(vehicleResponseEntity),
    );
    provideDummy<ApiResult<List<CountryEntity>>>(
      ApiSuccessResult(countryResponseEntity),
    );
  });
  testWidgets('apply test structure', (WidgetTester tester) async {
    await tester.pumpWidget(const TestAppWrapper(child: ApplyView()));
    when(
      mockGetAllVehiclesUseCase.call(),
    ).thenAnswer((_) async => ApiSuccessResult(vehicleResponseEntity));
    await tester.pumpAndSettle();
    expect(find.byType(AppBar), findsOneWidget);
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenLabel)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenIconArrowBack)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenPadding)),
      findsOneWidget,
    );
    expect(find.byType(TextFormField), findsNWidgets(12));
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenElevatedButtonContinue)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenTextGender)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(WidgetsKeys.kApplyScreenRadioGroup)),
      findsOneWidget,
    );
  });
}
