import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/enums/state_status.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:equatable/equatable.dart';

class EnergyState extends Equatable {
  const EnergyState({
    required this.energy,
    required this.selectedType,
    required this.isKilowatts,
    required this.selectedEnergyEntity,
    required this.stateStatus,
  });

  final List<EnergyTypeMapper> energy;
  final EnergyType selectedType;
  final bool isKilowatts;
  final EnergyEntity selectedEnergyEntity;
  final StateStatus stateStatus;

  EnergyState copyWith({
    List<EnergyTypeMapper>? energy,
    double? interval,
    EnergyType? selectedType,
    bool? isKilowatts,
    EnergyEntity? selectedEnergyEntity,
    StateStatus? stateStatus,
  }) {
    return EnergyState(
      energy: energy ?? this.energy,
      selectedType: selectedType ?? this.selectedType,
      isKilowatts: isKilowatts ?? this.isKilowatts,
      selectedEnergyEntity: selectedEnergyEntity ?? this.selectedEnergyEntity,
      stateStatus: stateStatus ?? this.stateStatus,
    );
  }

  @override
  List<Object?> get props => [
        energy,
        selectedType,
        isKilowatts,
        selectedEnergyEntity,
        stateStatus,
      ];
}

class EnergyTypeMapper extends Equatable {
  const EnergyTypeMapper({
    required this.energyList,
    required this.minY,
    required this.maxY,
  });

  final List<EnergyEntity> energyList;
  final double minY;
  final double maxY;

  @override
  List<Object?> get props => [energyList, minY, maxY];
}
