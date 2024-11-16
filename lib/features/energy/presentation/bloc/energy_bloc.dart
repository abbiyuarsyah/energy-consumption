import 'package:energy_consumption/features/energy/domain/use_case/get_energy.dart';

import 'energy_event.dart';
import 'energy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergyBloc extends Bloc<EnergyEvent, EnergyState> {
  EnergyBloc({required this.getEnergy})
      : super(const EnergyState(energyList: [])) {
    on<GetEnergyEvent>(_onGetEnergyEvent);
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
      emit(state.copyWith(energyList: r));
    });
  }
}
