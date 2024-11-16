import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:equatable/equatable.dart';

class EnergyState extends Equatable {
  const EnergyState({
    required this.energyList,
    required this.minY,
    required this.maxY,
    required this.interval,
    required this.selectedType,
  });

  final List<EnergyEntity> energyList;
  final double minY;
  final double maxY;
  final double interval;
  final EnergyType selectedType;

  EnergyState copyWith({
    List<EnergyEntity>? energyList,
    double? minY,
    double? maxY,
    double? interval,
    EnergyType? selectedType,
  }) {
    return EnergyState(
      energyList: energyList ?? this.energyList,
      minY: minY ?? this.minY,
      maxY: maxY ?? this.maxY,
      interval: interval ?? this.interval,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  List<Object?> get props => [energyList, minY, maxY, interval, selectedType];
}
