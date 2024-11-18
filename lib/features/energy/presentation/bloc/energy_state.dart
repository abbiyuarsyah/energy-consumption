import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/core/enums/status.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:equatable/equatable.dart';

class EnergyState extends Equatable {
  const EnergyState({
    required this.energy,
    required this.selectedType,
    required this.isKilowatts,
    required this.selectedEnergyEntity,
    required this.stateStatus,
    required this.selectedDate,
    required this.clearCacheStatus,
    required this.errorMessage,
  });

  final List<EnergyTypeMapper> energy;
  final EnergyType selectedType;
  final bool isKilowatts;
  final EnergyEntity selectedEnergyEntity;
  final StateStatus stateStatus;
  final DateTime selectedDate;
  final ClearCacheStatus clearCacheStatus;
  final String errorMessage;

  EnergyState copyWith({
    List<EnergyTypeMapper>? energy,
    double? interval,
    EnergyType? selectedType,
    bool? isKilowatts,
    EnergyEntity? selectedEnergyEntity,
    StateStatus? stateStatus,
    DateTime? selectedDate,
    ClearCacheStatus? clearCacheStatus,
    String? errorMessage,
  }) {
    return EnergyState(
      energy: energy ?? this.energy,
      selectedType: selectedType ?? this.selectedType,
      isKilowatts: isKilowatts ?? this.isKilowatts,
      selectedEnergyEntity: selectedEnergyEntity ?? this.selectedEnergyEntity,
      stateStatus: stateStatus ?? this.stateStatus,
      selectedDate: selectedDate ?? this.selectedDate,
      clearCacheStatus: clearCacheStatus ?? this.clearCacheStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        energy,
        selectedType,
        isKilowatts,
        selectedEnergyEntity,
        stateStatus,
        selectedDate,
        clearCacheStatus,
        errorMessage,
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
