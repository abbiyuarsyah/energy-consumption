import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';

import 'energy_event.dart';
import 'energy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergyBloc extends Bloc<EnergyEvent, EnergyState> {
  EnergyBloc({required this.getEnergy})
      : super(const EnergyState(
          solar: [],
          house: [],
          battery: [],
          minY: 0,
          maxY: 0,
          selectedType: EnergyType.solar,
        )) {
    on<GetEnergyEvent>(_onGetEnergyEvent, transformer: concurrent());
    on<SelectEnergyTypeEvent>(_onSelectEnergyTypeEvent);
  }

  final GetEnergy getEnergy;

  Future<void> _onGetEnergyEvent(
    GetEnergyEvent event,
    Emitter<EnergyState> emit,
  ) async {
    final result = await getEnergy(GetEnergyParams(
      date: event.date,
      type: event.type,
    ));

    result.fold((l) {}, (r) {
      final minY = r.reduce((a, b) => a.value < b.value ? a : b);
      final maxY = r.reduce((a, b) => a.value > b.value ? a : b);

      switch (event.type) {
        case EnergyType.house:
          emit(
            state.copyWith(
              house: event.type == EnergyType.house ? r : [],
              minY: minY.value.toDouble(),
              maxY: maxY.value.toDouble(),
            ),
          );
          break;
        case EnergyType.solar:
          emit(
            state.copyWith(
              solar: event.type == EnergyType.solar ? r : [],
              minY: minY.value.toDouble(),
              maxY: maxY.value.toDouble(),
            ),
          );
          break;
        case EnergyType.battery:
          emit(
            state.copyWith(
              battery: event.type == EnergyType.battery ? r : [],
              minY: minY.value.toDouble(),
              maxY: maxY.value.toDouble(),
            ),
          );
          break;
        default:
      }
    });
  }

  Future<void> _onSelectEnergyTypeEvent(
    SelectEnergyTypeEvent event,
    Emitter<EnergyState> emit,
  ) async {
    emit(state.copyWith(selectedType: event.type));
  }
}
