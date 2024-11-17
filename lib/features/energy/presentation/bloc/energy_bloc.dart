import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/enums/state_status.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';

import 'energy_event.dart';
import 'energy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergyBloc extends Bloc<EnergyEvent, EnergyState> {
  EnergyBloc({required this.getEnergy})
      : super(EnergyState(
          energy: const [],
          selectedType: EnergyType.solar,
          isKilowatts: false,
          selectedEnergyEntity: EnergyEntity.init(),
          stateStatus: StateStatus.init,
          selectedDate: DateTime.now(),
        )) {
    on<GetEnergyEvent>(_onGetEnergyEvent);
    on<SelectEnergyTypeEvent>(_onSelectEnergyTypeEvent);
    on<SwitchUnitEvent>(_onSwitchUnitEvent);
    on<SelectValueEvent>(_onSelectValueEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
  }

  final GetEnergy getEnergy;

  Future<void> _onGetEnergyEvent(
    GetEnergyEvent event,
    Emitter<EnergyState> emit,
  ) async {
    final List<EnergyTypeMapper> energyMapper = [];

    if (state.stateStatus != StateStatus.loading) {
      emit(state.copyWith(stateStatus: StateStatus.loading));
    }

    for (final type in EnergyType.values) {
      final result = await getEnergy(GetEnergyParams(
        date: event.date,
        type: type,
      ));

      result.fold((l) {
        emit(state.copyWith(stateStatus: StateStatus.failed));
      }, (r) {
        final minY = r.reduce((a, b) => a.value < b.value ? a : b);
        final maxY = r.reduce((a, b) => a.value > b.value ? a : b);

        energyMapper.insert(
          type.index,
          EnergyTypeMapper(
            energyList: r,
            minY: minY.value.toDouble(),
            maxY: maxY.value.toDouble(),
          ),
        );

        if (energyMapper.length != 3) {
          return;
        }

        emit(state.copyWith(
          stateStatus: StateStatus.loaded,
          selectedEnergyEntity: r.last,
          energy: energyMapper,
        ));
      });
    }
  }

  Future<void> _onSelectEnergyTypeEvent(
    SelectEnergyTypeEvent event,
    Emitter<EnergyState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedType: event.type,
        selectedEnergyEntity: state.energy[event.type.index].energyList.last,
      ),
    );
  }

  Future<void> _onSwitchUnitEvent(
    SwitchUnitEvent event,
    Emitter<EnergyState> emit,
  ) async {
    emit(state.copyWith(isKilowatts: event.isKiloWatts));
  }

  Future<void> _onSelectDateEvent(
    SelectDateEvent event,
    Emitter<EnergyState> emit,
  ) async {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  Future<void> _onSelectValueEvent(
    SelectValueEvent event,
    Emitter<EnergyState> emit,
  ) async {
    final selectedType = state.selectedType;
    var list = state.energy[selectedType.index].energyList;
    if (list.isEmpty) {
      return;
    }

    emit(state.copyWith(selectedEnergyEntity: list[event.selectedIndex]));
  }
}
