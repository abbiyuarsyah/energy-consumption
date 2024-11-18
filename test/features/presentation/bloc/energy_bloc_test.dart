import 'package:dartz/dartz.dart';
import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/enums/status.dart';
import 'package:energy_consumption/core/utils/execptions.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:energy_consumption/features/energy/domain/use_case/delete_cache.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'energy_bloc_test.mocks.dart';

@GenerateMocks([GetEnergy, DeleteCache])
void main() {
  late GetEnergy getEnergy;
  late DeleteCache deleteCache;
  late EnergyBloc energyBloc;
  late EnergyState energyState;

  setUp(() async {
    getEnergy = MockGetEnergy();
    deleteCache = MockDeleteCache();
    energyBloc = EnergyBloc(getEnergy: getEnergy, deleteCache: deleteCache);
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
    'getEnergy should emit [Loading, Loaded] when data is gotten successfully',
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
    'deleteCache should emit [init, Loaded] when data is gotten successfully',
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
    'deleteCache should emit [init, failed] when data is gotten successfully',
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
}
