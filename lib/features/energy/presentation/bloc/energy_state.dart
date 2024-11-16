import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:equatable/equatable.dart';

class EnergyState extends Equatable {
  const EnergyState({required this.energyList});

  final List<EnergyEntity> energyList;

  EnergyState copyWith({List<EnergyEntity>? energyList}) {
    return EnergyState(energyList: energyList ?? this.energyList);
  }

  @override
  List<Object?> get props => [energyList];
}
