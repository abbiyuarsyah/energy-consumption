import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/enums/status.dart';
import 'package:energy_consumption/core/shared_widget/error_screen_widget.dart';
import 'package:energy_consumption/core/utils/execptions.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:energy_consumption/features/energy/domain/use_case/delete_cache.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:energy_consumption/features/energy/presentation/pages/energy_consumption_page.dart';
import 'package:energy_consumption/features/energy/presentation/widgets/energy_detail_widget.dart';
import 'package:energy_consumption/features/energy/presentation/widgets/energy_graph_widget.dart';
import 'package:energy_consumption/features/energy/presentation/widgets/energy_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'energy_bloc_test.mocks.dart';

@GenerateMocks([GetEnergy, DeleteCache, EnergyBloc])
void main() {
  late GetEnergy getEnergy;
  late DeleteCache deleteCache;
  late EnergyBloc energyBloc;
  late EnergyState energyState;

  setUp(() async {
    getEnergy = MockGetEnergy();
    deleteCache = MockDeleteCache();
    energyBloc = MockEnergyBloc();
    energyState = EnergyState(
      energy: const [],
      selectedType: EnergyType.solar,
      isKilowatts: false,
      selectedEnergyEntity: EnergyEntity.init(),
      stateStatus: StateStatus.init,
      selectedDate: DateTime.now(),
      clearCacheStatus: ClearCacheStatus.init,
      errorMessage: '',
    );
  });

  // Helper method to wrap the widget with the mock bloc
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<EnergyBloc>(
        create: (_) => energyBloc,
        child: const EnergyConsumptionPage(),
      ),
    );
  }

  group("widget test", () {
    testWidgets('displays loading indicator when state is loading',
        (WidgetTester tester) async {
      when(energyBloc.state).thenReturn(
        energyState.copyWith(stateStatus: StateStatus.loading),
      );
      when(energyBloc.stream).thenAnswer(
        (_) => Stream.value(
          energyState.copyWith(stateStatus: StateStatus.loading),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error screen when state is failed',
        (WidgetTester tester) async {
      final errorMessage = tr('unexpected_error');

      when(energyBloc.state).thenReturn(
        energyState.copyWith(
          stateStatus: StateStatus.failed,
          errorMessage: errorMessage,
        ),
      );
      when(energyBloc.stream).thenAnswer(
        (_) => Stream.value(
          energyState.copyWith(
            stateStatus: StateStatus.failed,
            errorMessage: errorMessage,
          ),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(ErrorScreenWidget), findsOneWidget);
    });

    testWidgets('displays content when state is loaded',
        (WidgetTester tester) async {
      when(energyBloc.state).thenReturn(
        energyState.copyWith(stateStatus: StateStatus.loaded),
      );
      when(energyBloc.stream).thenAnswer(
        (_) => Stream.value(
          energyState.copyWith(stateStatus: StateStatus.loaded),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('monitoring'), findsOneWidget);
      expect(find.byType(EnergyTab), findsOneWidget);
      expect(find.byType(EnergyGraph), findsOneWidget);
      expect(find.byType(EnergyDetailWidget), findsOneWidget);
    });
  });

  group("unit test and use case test", () {
    test(
      'getEnergy should emit [loading, failed] when fetching data is failed',
      () async* {
        when(getEnergy(const GetEnergyParams(
          date: '2024-11-17',
          type: EnergyType.solar,
        ))).thenAnswer(
          (_) async => Left(UnexpectedFailure()),
        );

        final expected = [
          energyState.copyWith(stateStatus: StateStatus.init),
          energyState.copyWith(stateStatus: StateStatus.loading),
          energyState.copyWith(stateStatus: StateStatus.failed),
        ];
        expectLater(energyBloc, emitsInOrder(expected));
        energyBloc.add(const GetEnergyEvent(date: '2024-11-17'));
      },
    );

    test(
      'getEnergy should emit [Loading, succeed] when data is fetched successfully',
      () async* {
        when(getEnergy(const GetEnergyParams(
          date: '2024-11-17',
          type: EnergyType.solar,
        ))).thenAnswer(
          (_) async => Right([
            EnergyEntity(timestamp: DateTime.now(), value: 500),
            EnergyEntity(timestamp: DateTime.now(), value: 100)
          ]),
        );

        final expected = [
          energyState.copyWith(stateStatus: StateStatus.init),
          energyState.copyWith(stateStatus: StateStatus.loading),
          energyState.copyWith(stateStatus: StateStatus.loaded),
        ];
        expectLater(energyBloc, emitsInOrder(expected));
        energyBloc.add(const GetEnergyEvent(date: '2024-11-17'));
      },
    );

    test(
      'deleteCache should emit [init, succeed] when data is deleted successfully',
      () async* {
        when(deleteCache(null)).thenAnswer((_) async => const Right(null));

        final expected = [
          energyState.copyWith(clearCacheStatus: ClearCacheStatus.init),
          energyState.copyWith(clearCacheStatus: ClearCacheStatus.succeed),
        ];
        expectLater(energyBloc, emitsInOrder(expected));
        energyBloc.add(const ClearCacheEvent());
      },
    );

    test(
      'deleteCache should emit [init, failed] when data is failed to delete',
      () async* {
        when(deleteCache(null)).thenAnswer(
          (_) async => Left(DeleteCacheFailure()),
        );

        final expected = [
          energyState.copyWith(clearCacheStatus: ClearCacheStatus.init),
          energyState.copyWith(clearCacheStatus: ClearCacheStatus.failed),
        ];
        expectLater(energyBloc, emitsInOrder(expected));
        energyBloc.add(const ClearCacheEvent());
      },
    );
  });
}
